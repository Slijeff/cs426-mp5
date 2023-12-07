// Usage: opt -load-pass-plugin=libUnitProject.so -passes="unit-sccp"
#include "llvm/ADT/Statistic.h"
#include "llvm/Support/raw_ostream.h"

#include "UnitSCCP.h"

//#define DEBUG_TYPE UnitSCCP
#define DEBUG_TYPE "UnitSCCP"
// Define any statistics here
STATISTIC(NumInstRemoved, "Number of instructions removed");
STATISTIC(NumDeadBlocks, "Number of basic blocks unreachable");
STATISTIC(NumInstReplaced, "Number of instructions replaced with (simpler) instructions");

using namespace llvm;
using namespace cs426;

/// Main function for running the SCCP optimization
PreservedAnalyses UnitSCCP::run(Function& F, FunctionAnalysisManager& FAM) {
  dbgs() << "UnitSCCP running on " << F.getName() << "\n";

  // Perform the optimization

  // Set proper preserved analyses
  return PreservedAnalyses::all();
}
