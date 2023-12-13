#ifndef INCLUDE_UNIT_LICM_H
#define INCLUDE_UNIT_LICM_H
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/PassManager.h"

#include "UnitLoopInfo.h"

using namespace llvm;

namespace cs426 {
/// Loop Invariant Code Motion Optimization Pass
struct UnitLICM : PassInfoMixin<UnitLICM> {
  PreservedAnalyses run(Function& F, FunctionAnalysisManager& FAM);
  
  bool checkIsHandled(Instruction &I);
  void hoist(UnitLoopInfo &Loops);
public:
  int NumHoistedStores;
  int NumHoistedLoads;
  int NumHoistedComputationalInst;
};
} // namespace

#endif // INCLUDE_UNIT_LICM_H
