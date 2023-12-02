#ifndef INCLUDE_UNIT_LOOP_INFO_H
#define INCLUDE_UNIT_LOOP_INFO_H
#include "llvm/IR/PassManager.h"

using namespace llvm;

namespace cs426 {
/// An object holding information about the (natural) loops in an LLVM
/// function. At minimum this will need to identify the loops, may hold
/// additional information you find useful for your LICM pass
class Loop {
  // the order in blocksInLoop is not guaranteed, so we need loopStart and loopEnd
  // - loopEnd has a backedge to loopStart
  // - preHeader is the block right before loopStart
  public:
  BasicBlock* preHeader = NULL;
  BasicBlock* loopStart = NULL; 
  BasicBlock* loopEnd = NULL;
  std::vector<BasicBlock* > blocksInLoop = {}; 
};
class UnitLoopInfo {
  public:
  // Define this class to provide the information you need in LICM
  std::vector<Loop> allLoopsInFunction = {};
};

/// Loop Identification Analysis Pass. Produces a UnitLoopInfo object which
/// should contain any information about the loops in the function which is
/// needed for your implementation of LICM
class UnitLoopAnalysis : public AnalysisInfoMixin<UnitLoopAnalysis> {
  friend AnalysisInfoMixin<UnitLoopAnalysis>;
  static AnalysisKey Key;

public:
  typedef UnitLoopInfo Result;

  UnitLoopInfo run(Function &F, FunctionAnalysisManager &AM);

private:
  void findPred(BasicBlock *cur, std::set<BasicBlock *> &visited, std::vector<BasicBlock *> &path);
  void printBackEdgesToDebug(std::vector<std::pair<BasicBlock*, BasicBlock*>> &BE);
};
} // namespace
#endif // INCLUDE_UNIT_LOOP_INFO_H
