// Usage: opt -load-pass-plugin=libUnitProject.so -passes="unit-licm"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Support/raw_ostream.h"

#include "UnitLICM.h"
// #include "UnitLoopInfo.h"

#define DEBUG_TYPE UnitLICM
// Define any statistics here

using namespace llvm;
using namespace cs426;

/// Main function for running the LICM optimization
PreservedAnalyses UnitLICM::run(Function& F, FunctionAnalysisManager& FAM) {
  dbgs() << "UnitLICM running on " << F.getName() << "\n";
  // Acquires the UnitLoopInfo object constructed by your Loop Identification
  // (LoopAnalysis) pass
  UnitLoopInfo &Loops = FAM.getResult<UnitLoopAnalysis>(F);

  AAResults &AA = FAM.getResult<AAManager>(F);
  // Perform the optimization
  /*
  for (auto &I: instructions(F)) {
    dbgs() << checkIsHandled(I) << '\n';
  }*/
  
  hoist(Loops);

  // Set proper preserved analyses
  return PreservedAnalyses::all();
}

bool UnitLICM::checkIsHandled(Instruction &I) {
  bool isHandled = false;
  unsigned int opcode = I.getOpcode();
  if (I.isUnaryOp()) {
    isHandled = true;
  } else if (I.isBinaryOp()) {
    isHandled = true;
  } else if (I.isShift() || I.isBitwiseLogicOp()) {
    isHandled = true;
  } else if (opcode == Instruction::BitCast) {
    isHandled = true;
  } else if (opcode == Instruction::ICmp) {
    isHandled = true;
  } else if (opcode == Instruction::FCmp) {
    isHandled = true;
  } else if (opcode == Instruction::Select) {
    isHandled = true;
  } else if (opcode == Instruction::GetElementPtr) {
    isHandled = true;
  } else if (opcode == Instruction::Load) {
    isHandled = true;
  } else if (opcode == Instruction::Store) {
    isHandled = true;
  }

  return isHandled;
}