// Usage: opt -load-pass-plugin=libUnitProject.so -passes="unit-sccp"
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
  CFGWorklist.push_back(std::make_pair<BasicBlock *, BasicBlock *>(nullptr, &F.getEntryBlock()));
  for (auto &i : instructions(F)) {
    LatticeMap[dynamic_cast<Value*>(&i)] = Lattice();
  }

  // Set proper preserved analyses
  return PreservedAnalyses::all();
}
