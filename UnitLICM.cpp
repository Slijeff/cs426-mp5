// Usage: opt -load-pass-plugin=libUnitProject.so -passes="unit-licm"
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

  DominatorTree &DT = FAM.getResult<DominatorTreeAnalysis>(F);
  const TargetLibraryInfo &TLI = FAM.getResult<TargetLibraryAnalysis>(F);
  // Perform the optimization
  hoist(Loops, AA, DT, TLI);

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

bool UnitLICM::checkIsNoAliasInLoop(AAResults &AA, Instruction &inst, Loop loop) {
  std::vector<BasicBlock* > blocksInLoop = loop.blocksInLoop;
  BasicBlock *preHeader = loop.preHeader;
  for (BasicBlock *block: blocksInLoop) {
    BasicBlock &BB = *block;
    for (auto &inst2: BB) {
      if (inst.isIdenticalTo(&inst2)) {
        continue;
      }
      if (AA.isNoAlias(&inst, &inst2) == false) {
        return false;
      }
    }
  }
  return true;
}

void UnitLICM::hoist(UnitLoopInfo &Loops, AAResults &AA, DominatorTree &DT, const TargetLibraryInfo &TLI) {
  const Instruction *CtxI; // TODO What is the second parameter for isSafeToSpeculativelyExecute?

  std::vector<Loop> allLoopsInFunction = Loops.allLoopsInFunction;
  for (Loop loop: allLoopsInFunction) {
    std::vector<BasicBlock* > blocksInLoop = loop.blocksInLoop;
    BasicBlock *preHeader = loop.preHeader;
    for (BasicBlock *block: blocksInLoop) {
      BasicBlock &BB = *block;
      for (Instruction &inst: BB) {
        if (checkIsHandled(inst) == false) {
          continue;
        }
        

      
        if (inst.isVolatile() == false) {
          if (isSafeToSpeculativelyExecute(&inst, &inst, &DT, &TLI) == true) {

            if (inst.mayHaveSideEffects() == false) {
              // TODO check if guaranteed to be run at least once because don't want to execute an instruction once that was previously executed zero times 
              // TODO if all arguments are constant or defined out of the loop
              /*
              bool allArgumentsConst = true;
              for (auto &op: inst.operands()) {
                if (isa<ConstantData>(op)) {
                  
                } else {
                  allArgumentsConst = false;
                }
              }
              */
              /*
              for (User *U: inst.users()) {
                if (Instruction *I = dyn_cast<Instruction>(U)) {
                  dbgs() << inst;
                  dbgs() << " is used in instruction:\n";
                  dbgs() << *I << "\n";
                }
              }
              */
              // bool shouldHoist = allArgumentsConst;
              // if (shouldHoist) {}
              
              // TODO possible segmentation fault
              inst.eraseFromParent();
              BasicBlock::iterator BBI = preHeader->end();
              Instruction &preheader_last_inst = *BBI;
              inst.insertAfter(&preheader_last_inst);

            } else if (inst.mayHaveSideEffects() == true) {
              // If an instruction has side effects and is not a Store, leave the instruction as is
              if (inst.getOpcode() == Instruction::Store) {
                if (inst.mayReadOrWriteMemory()) {
                  Value *value = inst.getOperand(0);
                  if (isa<ConstantData>(value)) {
                    Value *address = inst.getOperand(1);
                    bool is_store_address_const = isa<ConstantData>(address);
                    bool no_alias_in_loop = checkIsNoAliasInLoop(AA, inst, loop);
                    if (is_store_address_const || no_alias_in_loop) {
                      // TODO possible segmentation fault
                      inst.eraseFromParent();
                      BasicBlock::iterator BBI = preHeader->end();
                      Instruction &preheader_last_inst = *BBI;
                      inst.insertAfter(&preheader_last_inst);

                    }

                  }
                } 
              }
            }

          }
        }
      }
    }
  }
}