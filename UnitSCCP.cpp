// Usage: opt -load-pass-plugin=libUnitProject.so -passes="unit-sccp"
#include <llvm/IR/InstrTypes.h>
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

void UnitSCCP::visitInstruction(Instruction &i) {
  auto prevLattice = lattice_map.get(cast<Value>(&i));
  auto curLattice = prevLattice;

  auto op = i.getOpcode();
  if (op == Instruction::PHI) {
    visitPhi(i, curLattice);
  } else if (op == Instruction::Br) {
    visitBranch(i, curLattice);
  } else if (isa<BinaryOperator>(i) || isa<UnaryOperator>(i)) {
    visitUnaryOrBinary(i, curLattice);
  }

}

void UnitSCCP::visitPhi(Instruction &i, Lattice &curStatus) {
  dbgs() << "Got Phi node: ";
  i.print(dbgs(), true);
  dbgs() << "\n";
}
void UnitSCCP::visitBranch(Instruction &i, Lattice &curStatus) {
  dbgs() << "Got Branch node: ";
  i.print(dbgs(), true);
  dbgs() << " | ";

  dbgs() << "# conditions: " << i.getNumOperands() << "\n";
  // unconditional branch
  if (i.getNumOperands() == 1) {
    auto *jmpTo = dyn_cast<BasicBlock>(i.getOperand(0));
    CFGWorklist.emplace_back(i.getParent(), jmpTo);
    return;
  }
}
void UnitSCCP::visitUnaryOrBinary(Instruction &i, Lattice &curStatus) {
  dbgs() << "Got Unary or Binary node: ";
  i.print(dbgs(), true);
  dbgs() << "\n";
}


