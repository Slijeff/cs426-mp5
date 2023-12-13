// Usage: opt -load-pass-plugin=libUnitProject.so -passes="unit-sccp"
#include <llvm/IR/InstrTypes.h>
#include <iostream>
#include "llvm/IR/Instructions.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "UnitSCCP.h"

//#define DEBUG_TYPE UnitSCCP
#define DEBUG_TYPE "UnitSCCP"
// Define any statistics here
//STATISTIC(NumInstRemoved, "Number of instructions removed");
//STATISTIC(NumDeadBlocks, "Number of basic blocks unreachable");
//STATISTIC(NumInstReplaced, "Number of instructions replaced with (simpler) instructions");

using namespace llvm;
using namespace cs426;

/// Main function for running the SCCP optimization
PreservedAnalyses UnitSCCP::run(Function &F, FunctionAnalysisManager &FAM) {
  dbgs() << "UnitSCCP running on " << F.getName() << "\n";

  // Perform the optimization

  // Initialization Phase
  clearAll();
  CFGWorklist.emplace_back(nullptr, &F.getEntryBlock());
  for (auto &i : instructions(F)) {
    lattice_map.set(cast<Value>(&i), Lattice(LatticeStatus::TOP, nullptr));
  }

  size_t cfgIndex = 0;
  size_t ssaIndex = 0;

  while (cfgIndex < CFGWorklist.size() || ssaIndex < SSAWorklist.size()) {
    while (cfgIndex < CFGWorklist.size()) processCFG(cfgIndex++);
    while (ssaIndex < SSAWorklist.size()) processSSA(ssaIndex++);
  }

  dbgs() << lattice_map;
  // Set proper preserved analyses
  return PreservedAnalyses::all();
}

// Process an item in the CFG worklist
void UnitSCCP::processCFG(size_t cfgIndex) {
  dbgs() << "processing cfg at index: " << cfgIndex << "\n";
  auto [prevBB, curBB] = CFGWorklist[cfgIndex];
  // we only iterate every edge once
  if (Visited.count({prevBB, curBB}) != 0) return;
  Visited.insert({prevBB, curBB});

  for (auto &i : *curBB) {
    visitInstruction(i);
  }
}

void UnitSCCP::processSSA(size_t ssaIndex) {
  dbgs() << "processing ssa at index: " << ssaIndex << "\n";
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
    visitBranch(cast<BranchInst>(i), curLattice);
  } else if (isa<BinaryOperator>(i) || isa<UnaryOperator>(i) || isa<CmpInst>(i)) {
    visitFoldable(i, curLattice);
  } else {
    curLattice.status = LatticeStatus::BOTTOM;
  }

  if (prevLattice != curLattice) {
    lattice_map.set(&i, curLattice);
    for (auto use : i.users()) {
      auto* user_inst = dyn_cast<Instruction>(use);
      SSAWorklist.push_back(user_inst);
    }
  }

}

void UnitSCCP::visitPhi(PHINode &i, Lattice &curStatus) {
  dbgs() << "Got Phi node: ";
  i.print(dbgs(), true);
  dbgs() << "\n";
  const size_t phi_size = i.getNumOperands() / 2;
  for (size_t idx = 0; idx < phi_size; idx++) {
    // FIXME: double check it's getting the incoming block
    auto *prevBB = i.getIncomingBlock(2 * idx + 1);
    if (Visited.count({prevBB, i.getParent()}) != 0) {
      auto *op = i.getOperand(idx * 2);
      auto opStatus = lattice_map.get(op);
      curStatus ^= opStatus;
    }
  }
}
void UnitSCCP::visitBranch(BranchInst &i, Lattice &curStatus) {
  dbgs() << "Got Branch node: ";
  i.print(dbgs(), true);
  dbgs() << "\n";

//  dbgs() << "# conditions: " << i.getNumOperands() << "\n";
  // unconditional branch
  if (i.isUnconditional()) {
    auto *jmpTo = i.getSuccessor(0);
    CFGWorklist.emplace_back(i.getParent(), jmpTo);
    return;
  }
  auto *thenBB = i.getSuccessor(1);
  auto *elseBB = i.getSuccessor(2);
}
void UnitSCCP::visitFoldable(Instruction &i, Lattice &curStatus) {
  dbgs() << "Got Foldable node: ";
  i.print(dbgs(), true);
  dbgs() << "\n";
}


