#ifndef INCLUDE_UNIT_LICM_H
#define INCLUDE_UNIT_LICM_H
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/PassManager.h"

#include "UnitLoopInfo.h"

using namespace llvm;

namespace cs426 {
/// Loop Invariant Code Motion Optimization Pass
struct UnitLICM : PassInfoMixin<UnitLICM> {
  PreservedAnalyses run(Function& F, FunctionAnalysisManager& FAM);
  
  bool checkIsHandled(Instruction &I);
  bool checkIsNoAliasInLoop(AAResults &AA, Instruction &inst, Loop loop);
  void hoist(UnitLoopInfo &Loops, AAResults &AA, DominatorTree &DT, const TargetLibraryInfo &TLI);
public:
  int NumHoistedStores;
  int NumHoistedLoads;
  int NumHoistedComputationalInst;
};
} // namespace

#endif // INCLUDE_UNIT_LICM_H
