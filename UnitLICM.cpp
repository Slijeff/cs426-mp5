// Usage: opt -load-pass-plugin=libUnitProject.so -passes="unit-licm"
#include "llvm/ADT/Statistic.h"
#include "llvm/Support/raw_ostream.h"

#include "UnitLICM.h"
#include "UnitLoopInfo.h"

//#define DEBUG_TYPE UnitLICM
#define DEBUG_TYPE "UnitLICM"
// Define any statistics here
STATISTIC(NumStores, "Number of hoisted stores added");
STATISTIC(NumLoads, "Number of hoisted loads added");
STATISTIC(NumCompHoisted, "Number of computational instructions that are hoisted");

using namespace llvm;
using namespace cs426;

/// Main function for running the LICM optimization
PreservedAnalyses UnitLICM::run(Function& F, FunctionAnalysisManager& FAM) {
  dbgs() << "UnitLICM running on " << F.getName() << "\n";
  // Acquires the UnitLoopInfo object constructed by your Loop Identification
  // (LoopAnalysis) pass
  UnitLoopInfo &Loops = FAM.getResult<UnitLoopAnalysis>(F);

  // Perform the optimization

  // Set proper preserved analyses
  return PreservedAnalyses::all();
}
