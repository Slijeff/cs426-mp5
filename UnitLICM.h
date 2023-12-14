#ifndef INCLUDE_UNIT_LICM_H
#define INCLUDE_UNIT_LICM_H
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/PassManager.h"
#include <map>
#include <set>


#include "UnitLoopInfo.h"

using namespace llvm;

namespace cs426 {
/// Loop Invariant Code Motion Optimization Pass
struct UnitLICM : PassInfoMixin<UnitLICM> {
  PreservedAnalyses run(Function& F, FunctionAnalysisManager& FAM);
  
  bool checkIsHandled(Instruction &I);
  bool checkIsComputationalInstruction(Instruction &I);

  bool checkIsNoAliasInLoop(AAResults &AA, Instruction &inst, Loop loop);
  void VisitLoops(UnitLoopInfo &Loops, AAResults &AA, DominatorTree &DT, const TargetLibraryInfo &TLI);
  void printStats();

  void BuildUseDefInstMap(Function& F);
  bool checkIsInstructionInLoop(Instruction *I, Loop loop);
  void hoistInstruction(Instruction &I, Loop loop);
public:
  std::map<Instruction *, std::vector<Instruction *>> UseDefInstMap;

  int NumHoistedStores;
  int NumHoistedLoads;
  int NumHoistedComputationalInst;
};
} // namespace

#endif // INCLUDE_UNIT_LICM_H
