// Usage: opt -load-pass-plugin=libUnitProject.so -passes="unit-licm"
#include "llvm/Support/raw_ostream.h"

#include "UnitLICM.h"
// #include "UnitLoopInfo.h"

#define DEBUG_TYPE UnitLICM
// Define any statistics here

using namespace llvm;
using namespace cs426;

#define NOTFOUND(list, elem) \
    std::find(list.begin(), list.end(), elem) == list.end()

#define FOUND(list, elem) \
    std::find(list.begin(), list.end(), elem) != list.end()
/// Main function for running the LICM optimization
PreservedAnalyses UnitLICM::run(Function &F, FunctionAnalysisManager &FAM) {
  dbgs() << "UnitLICM running on " << F.getParent()->getSourceFileName() << " -- " << F.getName() << "\n";
  // Acquires the UnitLoopInfo object constructed by your Loop Identification
  // (LoopAnalysis) pass
  UnitLoopInfo &Loops = FAM.getResult<UnitLoopAnalysis>(F);

  AAResults &AA = FAM.getResult<AAManager>(F);

  DominatorTree &DT = FAM.getResult<DominatorTreeAnalysis>(F);
  const TargetLibraryInfo &TLI = FAM.getResult<TargetLibraryAnalysis>(F);


  // Begin optimization
  markedInvariants.clear();

  bool has_changed;
  do {
    has_changed = false;
    for (auto &loop : Loops.allLoopsInFunction) {
      for (auto BB : loop.blocksInLoop) {
        for (auto &I : *BB) {
          // if the current instruction is not in markedInvariants and is also an invariant
          if (NOTFOUND(markedInvariants, &I) && isInvariant(I, loop, AA)) {
            has_changed = true;
            markedInvariants.push_back(&I);
            invariantToLoop[&I] = &loop;
          }
        }
      }
    }
  } while (has_changed);

  // moving instructions
  // TODO: correctly compute the preheader for the inner loop to be the preheader of the outer loop, possibly in UnitLoopInfo
  for (auto I : markedInvariants) {
    if (domAllExits(*I, *invariantToLoop[I], DT)) {
      moveToPreheader(*I, *invariantToLoop[I]);
      NumHoistedComputationalInst++; // TODO: properly compute statistics
    }
  }

  dbgs() << "NumHoisedComputationalInst: " << NumHoistedComputationalInst <<"\n\n";
  // Set proper preserved analyses
  return PreservedAnalyses::all();
}
bool UnitLICM::isInvariant(Instruction &i, Loop &loop, AAResults &AA) {
  // assume an instruction is invariant until proven otherwise
  bool is_invariant = true;
  for (auto &op : i.operands()) {
    auto *val = dyn_cast<Value>(op);
    // If the operand is not a constant or not an argument to the current function,
    // then it has the possibility to become a variant
    if (!isa<Constant>(val) && !isa<Argument>(val)) {
      if (auto *inst = dyn_cast<Instruction>(val)) {
        // If the operand is not an invariant, and it cannot be found outside the loop
        // then it's definitely not an invariant
        if (NOTFOUND(markedInvariants, inst) && FOUND(loop.blocksInLoop, inst->getParent())) {
          is_invariant = false;
        }
      } else {
        // In the case that it's not a valid instruction
        is_invariant = false;
      }
    }
  }
  return is_invariant &&
      isSafeToSpeculativelyExecute(&i) &&
      !i.mayReadFromMemory();// TODO: should handle load and store using AliasAnalysis
}

// Since loop-rotate pass ensures only one exit, we only need to check if current BB dominates that exit
bool UnitLICM::domAllExits(Instruction &inst, Loop &loop, DominatorTree &DT) {
  return DT.dominates(inst.getParent(), loop.loopEnd);
}
void UnitLICM::moveToPreheader(Instruction &inst, Loop &loop) {
  auto preheader = loop.preHeader;
  inst.moveBefore(preheader->getTerminator());
}
