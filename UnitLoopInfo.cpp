#include "llvm/IR/Dominators.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include "UnitLoopInfo.h"

using namespace llvm;
using namespace cs426;

/// Main function for running the Loop Identification analysis. This function
/// returns information about the loops in the function via the UnitLoopInfo
/// object
UnitLoopInfo UnitLoopAnalysis::run(Function &F, FunctionAnalysisManager &FAM)
{
  dbgs() << "UnitLoopAnalysis running on " << F.getName() << "\n";
  // Acquires the Dominator Tree constructed by LLVM for this function. You may
  // find this useful in identifying the natural loops
  DominatorTree &DT = FAM.getResult<DominatorTreeAnalysis>(F);

  UnitLoopInfo Loops;
  // We are using the loop-simplify pass, so the number of back edges = number of loops
  std::vector<std::pair<BasicBlock *, BasicBlock *>> AllBackEdges;
  // Fill in appropriate information
  for (auto curNode = GraphTraits<DominatorTree *>::nodes_begin(&DT);
       curNode != GraphTraits<DominatorTree *>::nodes_end(&DT); ++curNode)
  {
    auto curSuccessors = successors(curNode->getBlock());
    // if a node in the successor dominates the current node, then we found a back edge
    for (auto suc : curSuccessors)
    {
      DomTreeNode *successorNode = DT.getNode(suc);
      if (DT.dominates(successorNode, *curNode))
      {
        auto loopStart = suc;
        auto loopEnd = curNode->getBlock();
        AllBackEdges.emplace_back(loopEnd, loopStart); // back edge from end to start
      }
    }
  }

//  printBackEdgesToDebug(AllBackEdges);
  for (auto [end, start] : AllBackEdges)
  {
    Loop singleLoopInfo = {};
    singleLoopInfo.loopStart = start;
    singleLoopInfo.loopEnd = end;
    if (start == end) {
      singleLoopInfo.preHeader = DT.getNode(end)->getIDom()->getBlock();
    } else {
      // FIXME: double check the definition of preheader
      singleLoopInfo.preHeader = DT.getNode(end)->getIDom()->getIDom()->getBlock();
    }
    std::set<BasicBlock *> visited = {start};
    std::vector<BasicBlock *> loopBlocks = {start};
    findPred(end, visited, loopBlocks);
    singleLoopInfo.blocksInLoop.insert(singleLoopInfo.blocksInLoop.end(), loopBlocks.begin(), loopBlocks.end());
    Loops.allLoopsInFunction.push_back(singleLoopInfo);
  }

//  printAllLoops(Loops);
  return Loops;
}

void UnitLoopAnalysis::findPred(BasicBlock *curNode, std::set<BasicBlock *> &visited, std::vector<BasicBlock *> &path)
{
  if (visited.count(curNode))
  {
    return;
  }
  path.push_back(curNode);
  visited.insert(curNode);
  for (auto preds : predecessors(curNode))
  {
    findPred(preds, visited, path);
  }
}

void UnitLoopAnalysis::printBackEdgesToDebug(std::vector<std::pair<BasicBlock *, BasicBlock *>> &BE)
{
  dbgs() << "Back Edges: \n";
  for (auto [from, to] : BE)
  {
    from->printAsOperand(dbgs(), false);
    dbgs() << " --> ";
    to->printAsOperand(dbgs(), false);
    dbgs() << "\n";
  }
}

// After the loop analysis, print out all the loops
void UnitLoopAnalysis::printAllLoops(UnitLoopInfo &info){
  dbgs() << "Found " << info.allLoopsInFunction.size() << " loops: \n"; 
  int i = 1;
  for (auto &loop : info.allLoopsInFunction) {
    dbgs() << "  Loop " << i << " preheader: ";
    loop.preHeader->printAsOperand(dbgs(), false);
    dbgs() << "\n\t";
    for (auto &B : loop.blocksInLoop) {
      B->printAsOperand(dbgs(), false);
      dbgs() << ", ";
    }
    dbgs() << "\n";
    i++;
  }
}

AnalysisKey UnitLoopAnalysis::Key;
