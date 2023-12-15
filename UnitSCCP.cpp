// Usage: opt -load-pass-plugin=libUnitProject.so -passes="unit-sccp"
#include <llvm/IR/InstrTypes.h>
#include "llvm/IR/Instructions.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/InstIterator.h"
#include "UnitSCCP.h"

//#define DEBUG_TYPE UnitSCCP
#define DEBUG_TYPE "UnitSCCP"

using namespace llvm;
using namespace cs426;

/// Main function for running the SCCP optimization
PreservedAnalyses UnitSCCP::run(Function &F, FunctionAnalysisManager &FAM) {
  dbgs() << "UnitSCCP running on " << F.getParent()->getSourceFileName() << " -- " << F.getName() << "\n";
  if (F.isDeclaration()) return PreservedAnalyses::all();
  // Perform the optimization

  // Initialization Phase
  clearAll();
  CFGWorklist.emplace_back(nullptr, &F.getEntryBlock());
  for (auto &i : instructions(F)) {
    lattice_map.set(&i, Lattice(LatticeStatus::TOP, nullptr));
  }

  size_t cfgIndex = 0;
  size_t ssaIndex = 0;

  while (cfgIndex < CFGWorklist.size() || ssaIndex < SSAWorklist.size()) {
    while (cfgIndex < CFGWorklist.size()) processCFG(cfgIndex++);
    while (ssaIndex < SSAWorklist.size()) processSSA(ssaIndex++);
  }

//  dbgs() << lattice_map;
  replaceConsts(F);
  dbgs() <<"\n";
  // Set proper preserved analyses
  return PreservedAnalyses::all();
}

// Process an item in the CFG worklist
void UnitSCCP::processCFG(size_t cfgIndex) {
//  dbgs() << "processing cfg at index: " << cfgIndex << "\n";
  auto [prevBB, curBB] = CFGWorklist[cfgIndex];
  // we only iterate every edge once
  if (Visited.count({prevBB, curBB}) != 0) return;
  Visited.insert({prevBB, curBB});

  for (auto &i : *curBB) {
    visitInstruction(i);
  }
}

void UnitSCCP::processSSA(size_t ssaIndex) {
//  dbgs() << "processing ssa at index: " << ssaIndex << "\n";
  auto *instruction = SSAWorklist[ssaIndex];
  auto *BB = instruction->getParent();
  for (auto pred : predecessors(BB)) {
    if (Visited.count({pred, BB}) != 0) {
      visitInstruction(*instruction);
      break;
    }
  }
}

void UnitSCCP::visitInstruction(Instruction &i) {
  auto prevLattice = lattice_map.get(&i);
  auto curLattice = prevLattice;

  if (isa<PHINode>(i)) {
    visitPhi(cast<PHINode>(i), curLattice);
  } else if (isa<BranchInst>(i)) {
    visitBranch(cast<BranchInst>(i));
  } else if (isa<BinaryOperator>(i) || isa<UnaryOperator>(i) || isa<CmpInst>(i) || isa<SelectInst>(i)) {
    visitFoldable(i, curLattice);
  } else {
    curLattice.status = LatticeStatus::BOTTOM;
  }

  if (prevLattice != curLattice) {
    lattice_map.set(&i, curLattice);
    for (auto use : i.users()) {
      auto *user_inst = dyn_cast<Instruction>(use);
      SSAWorklist.push_back(user_inst);
    }
  }

}

void UnitSCCP::visitPhi(PHINode &i, Lattice &curStatus) {
//  dbgs() << "Got Phi node: ";
//  i.print(dbgs(), true);
//  dbgs() << "\n";
//  const size_t phi_size = i.getNumOperands() / 2;
  const size_t phi_size = i.getNumIncomingValues();
  for (size_t idx = 0; idx < phi_size; idx++) {
//    auto *prevBB = i.getIncomingBlock(2 * idx + 1);
    auto *prevBB = i.getIncomingBlock(idx);
    if (Visited.count({prevBB, i.getParent()}) != 0) {
//      auto *op = i.getOperand(idx * 2);
      auto *op = i.getOperand(idx);
      auto opStatus = lattice_map.get(op);
      curStatus ^= opStatus;
    }
  }
}
void UnitSCCP::visitBranch(BranchInst &i) {
//  dbgs() << "Got Branch node: ";
//  i.print(dbgs(), true);
//  dbgs() << "\n";

//  dbgs() << "# ops: " << i.getNumOperands() << "\n";
  // unconditional branch
  if (i.isUnconditional()) {
    auto *jmpTo = i.getSuccessor(0);
    CFGWorklist.emplace_back(i.getParent(), jmpTo);
    return;
  }
  auto *thenBB = i.getSuccessor(0);
  auto *elseBB = i.getSuccessor(1);
  if (lattice_map.get(i.getOperand(0)).constant != nullptr) {
    auto *condition = dyn_cast<ConstantInt>(lattice_map.get(i.getOperand(0)).constant);
    if (condition != nullptr) {
      condition->getValue() == 0 ? CFGWorklist.emplace_back(i.getParent(), elseBB)
                                 : CFGWorklist.emplace_back(i.getParent(), thenBB);
    }
  } else {
    CFGWorklist.emplace_back(i.getParent(), elseBB);
    CFGWorklist.emplace_back(i.getParent(), thenBB);
  }

}
void UnitSCCP::visitFoldable(Instruction &i, Lattice &curStatus) {
//  dbgs() << "Got Foldable node: ";
//  i.print(dbgs(), true);
//  dbgs() << "\n";

  Constant *folded = nullptr;
  if (isa<CmpInst>(i)) {
    auto *e1 = lattice_map.get(i.getOperand(0)).constant;
    auto *e2 = lattice_map.get(i.getOperand(1)).constant;
    if (e1 != nullptr && e2 != nullptr) {
      folded = calculateCompare(cast<CmpInst>(i), e1, e2);
    }
  } else if (isa<BinaryOperator>(i)) {
    auto *e1 = lattice_map.get(i.getOperand(0)).constant;
    auto *e2 = lattice_map.get(i.getOperand(1)).constant;
    if (e1 != nullptr && e2 != nullptr) {
      folded = calculateBinaryOp(cast<BinaryOperator>(i), e1, e2);
    }
  } else if (isa<SelectInst>(i)) {
    auto *e1 = lattice_map.get(i.getOperand(0)).constant;
    auto *e2 = lattice_map.get(i.getOperand(1)).constant;
    if (e1 != nullptr && e2 != nullptr) {
      folded = calculateSelect(cast<SelectInst>(i), e1, e2);
    }
  } else {
    auto *e1 = lattice_map.get(i.getOperand(0)).constant;
    if (e1 != nullptr) {
      folded = calculateUnaryOp(cast<UnaryOperator>(i), e1);
    }
  }

  if (folded != nullptr) {
    curStatus.constant = cast<ConstantData>(folded);
    curStatus.status = LatticeStatus::CONST;
    return;
  }

  curStatus.status = LatticeStatus::TOP;
  for (auto &op : i.operands()) {
    if (lattice_map.get(op).isBottom()) {
      curStatus.status = LatticeStatus::BOTTOM;
      curStatus.constant = nullptr;
      return;
    }
  }
}
ConstantData *UnitSCCP::calculateUnaryOp(UnaryOperator &inst, ConstantData *e) {
  auto op = inst.getOpcode();

  auto toAPInt = [](ConstantData *d) -> APInt { return dyn_cast<ConstantInt>(d)->getValue(); };
  auto toAPFloat = [](ConstantData *d) -> APFloat { return dyn_cast<ConstantFP>(d)->getValue(); };

  auto resType = inst.getType();
  switch (op) {
    case Instruction::FNeg: return cast<ConstantData>(ConstantFP::get(resType, neg(toAPFloat(e))));
    default:return nullptr;
  }
}
ConstantData *UnitSCCP::calculateBinaryOp(BinaryOperator &inst, ConstantData *e1, ConstantData *e2) {
  auto op = inst.getOpcode();

  auto toAPInt = [](ConstantData *d) -> APInt { return dyn_cast<ConstantInt>(d)->getValue(); };
  auto toAPFloat = [](ConstantData *d) -> APFloat { return dyn_cast<ConstantFP>(d)->getValue(); };

  auto resType = inst.getType();
  switch (op) {
    case Instruction::Add:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1) + toAPInt(e2)));
    case Instruction::Sub:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1) - toAPInt(e2)));
    case Instruction::SDiv:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1).sdiv(toAPInt(e2))));
    case Instruction::UDiv:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1).udiv(toAPInt(e2))));
    case Instruction::Mul:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1) * toAPInt(e2)));
    case Instruction::SRem:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1).srem(toAPInt(e2))));
    case Instruction::URem:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1).urem(toAPInt(e2))));
    case Instruction::Shl:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1).shl(toAPInt(e2))));
    case Instruction::LShr:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1).lshr(toAPInt(e2))));
    case Instruction::AShr:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1).ashr(toAPInt(e2))));
    case Instruction::And:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1) & (toAPInt(e2))));
    case Instruction::Or:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1) | (toAPInt(e2))));
    case Instruction::Xor:return cast<ConstantData>(ConstantInt::get(resType, toAPInt(e1) ^ (toAPInt(e2))));

    case Instruction::FAdd:return cast<ConstantData>(ConstantFP::get(resType, toAPFloat(e1) + toAPFloat(e2)));
    case Instruction::FSub:return cast<ConstantData>(ConstantFP::get(resType, toAPFloat(e1) - toAPFloat(e2)));
    case Instruction::FDiv:return cast<ConstantData>(ConstantFP::get(resType, toAPFloat(e1) / toAPFloat(e2)));
    case Instruction::FMul:return cast<ConstantData>(ConstantFP::get(resType, toAPFloat(e1) * toAPFloat(e2)));
    case Instruction::FRem:return cast<ConstantData>(ConstantFP::get(resType, toAPFloat(e1).remainder(toAPFloat(e2))));
    default:return nullptr;
  }
}
ConstantData *UnitSCCP::calculateCompare(CmpInst &inst, ConstantData *e1, ConstantData *e2) {
  auto op = inst.getPredicate();

  auto toAPInt = [](ConstantData *d) -> APInt { return dyn_cast<ConstantInt>(d)->getValue(); };
  auto toAPFloat = [](ConstantData *d) -> APFloat { return dyn_cast<ConstantFP>(d)->getValue(); };

  auto resType = inst.getType();
  if (isa<ICmpInst>(inst)) {
    return cast<ConstantData>(ConstantInt::get(resType, ICmpInst::compare(toAPInt(e1), toAPInt(e2), op)));
  } else if (isa<FCmpInst>(inst)) {
    return cast<ConstantData>(ConstantInt::get(resType, FCmpInst::compare(toAPFloat(e1), toAPFloat(e2), op)));
  } else {
    return nullptr;
  }
}
void UnitSCCP::replaceConsts(Function &F) {
  dbgs() << "Replacing constants...\n";
  std::vector<Instruction *> remove;
  for (auto &i : instructions(F)) {
    if (auto constant = lattice_map.get(&i).constant) {
      NumInstReplaced += i.getNumUses();
      i.replaceAllUsesWith(constant);
      remove.push_back(&i);
    }
  }
  NumInstRemoved += remove.size();
  for (auto i : remove) i->removeFromParent();

  for (auto &BB : F) {
    auto *brInst = dyn_cast<BranchInst>(BB.getTerminator());
    if (brInst == nullptr || brInst->isUnconditional()) continue;
    auto *condition = dyn_cast<ConstantInt>(brInst->getOperand(0));
    if (condition == nullptr) continue;
    auto thenBB = brInst->getSuccessor(0);
    auto elseBB = brInst->getSuccessor(1);
    if (condition->getValue() != 0) {
      eliminateConditionBranch(brInst, thenBB, elseBB);
    } else {
      eliminateConditionBranch(brInst, elseBB, thenBB);
    }
  }

  dbgs() << "NumInstRemoved: " << NumInstRemoved << " | NumInstReplaced: " << NumInstReplaced
         << " | NumDeadBlocks: " << NumDeadBlocks << "\n";
}
void UnitSCCP::eliminateConditionBranch(BranchInst *inst, BasicBlock *jmp, BasicBlock *invalid) {
  BranchInst::Create(jmp, inst);
  inst->removeFromParent();
  if (jmp == invalid) {
    return;
  }
  NumDeadBlocks++;
}
ConstantData *UnitSCCP::calculateSelect(SelectInst &inst, ConstantData *e1, ConstantData *e2) {
  auto cond = lattice_map.get(inst.getCondition());
  if (cond.isBottom() || cond.isTop()) return nullptr;
  if (auto cd = dyn_cast<ConstantInt>(cond.constant)) {
    auto res = cd->getZExtValue() == 1 ? e1 : e2;
    return res;
  }
  return nullptr;
}

