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

public:
//  std::map<Instruction *, std::vector<Instruction *>> UseDefInstMap;

  std::vector<Instruction*> markedInvariants;
  std::map<Instruction*, Loop*> invariantToLoop;


  bool isInvariant(Instruction &inst, Loop &loop, AAResults &AA);
  bool domAllExits(Instruction &inst, Loop &loop, DominatorTree &DT);
  void moveToPreheader(Instruction &inst, Loop &loop);
  bool checkIsComputationalInstruction(Instruction &I);
  bool hasAlias(Instruction &inst, Loop &loop, AAResults &AA);
  void printStats();
  bool checkIsHandled(Instruction &I);

  size_t NumHoistedStores;
  size_t NumHoistedLoads;
  size_t NumHoistedComputationalInst;
};
} // namespace

#endif // INCLUDE_UNIT_LICM_H
