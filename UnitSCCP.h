#ifndef INCLUDE_UNIT_SCCP_H
#define INCLUDE_UNIT_SCCP_H
#include <llvm/IR/Constants.h>
#include <map>
#include "llvm/IR/PassManager.h"

using namespace llvm;

namespace cs426 {
enum LatticeStatus {
  BOTTOM,
  CONST,
  TOP
};
/// The Lattice
class Lattice {
 public:
  Lattice() {
    status = LatticeStatus::TOP;
    constant = nullptr;
  };
  LatticeStatus status;
  ConstantData *constant;

  explicit Lattice(LatticeStatus s, ConstantData *val) {
    status = s;
    constant = val;
  }

  [[nodiscard]] bool isBottom() const { return status == BOTTOM; }
  [[nodiscard]] bool isConst() const { return status == CONST; }
  [[nodiscard]] bool isTop() const { return status == TOP; }

  bool operator!=(Lattice &other) const {
    if (status != other.status) return true;
    else if (status != CONST) return false;
    else {
      return constant != other.constant;
    }
//    else if (reinterpret_cast<ConstantInt *>(constant) != nullptr) {
//      APInt x = reinterpret_cast<ConstantInt *>(constant)->getValue();
//      APInt y = reinterpret_cast<ConstantInt *>(other.constant)->getValue();
//      return x != y;
//    } else if (reinterpret_cast<ConstantFP *>(constant) != nullptr) {
//      APFloat x = reinterpret_cast<ConstantFP *>(constant)->getValue();
//      APFloat y = reinterpret_cast<ConstantFP *>(other.constant)->getValue();
//      return x != y;
//    }

    dbgs() << "shouldn't get here!\n";
    return false;
  }

  void operator^=(Lattice &other) {
    if (other.status < status) {
      status = other.status;
      constant = other.constant;
    } else {
      if (constant == other.constant) return;
      status = BOTTOM;
      constant = nullptr;
    }
//    else if (status == other.status && status == CONST) {
//      auto x = dynamic_cast<Value *>(constant);
//      auto y = dynamic_cast<Value *>(other.constant);
//      if (x != y) {
//        status = LatticeStatus::BOTTOM;
//        constant = nullptr;
//      }
//    }
  }

  friend llvm::raw_ostream& operator<<(llvm::raw_ostream& output, Lattice const &lattice){
    std::string lat;
    switch (lattice.status) {
      case BOTTOM:
        lat = "BOTTOM";
        break;
      case CONST:
        lat = "CONST";
        break;
      case TOP:
        lat = "TOP";
        break;
    }
    return output << "[Lattice: " << lat << "]";
  }
};

class LatticeMap {
 private:
  std::map<Value *, Lattice> lattice_map_;
 public:
  void clear() { lattice_map_.clear(); }
  Lattice get(Value *key) {
    if (auto constant = dyn_cast<ConstantData>(key)) {
      return Lattice(LatticeStatus::CONST, constant);
    }
    return lattice_map_[key];
  }
  void set(Value *k, Lattice v) {
    lattice_map_[k] = v;
  }
  friend llvm::raw_ostream& operator<<(llvm::raw_ostream& output, LatticeMap const &LM) {
    for (auto [k,v] : LM.lattice_map_) {
      output << v << "\n";
    }
    return output;
  }
};
/// Sparse Conditional Constant Propagation Optimization Pass
struct UnitSCCP : PassInfoMixin<UnitSCCP> {
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM);
 private:
  LatticeMap lattice_map;
  std::vector<std::pair<BasicBlock *, BasicBlock *>> CFGWorklist;
  std::vector<Instruction *> SSAWorklist;
  std::set<std::pair<BasicBlock *, BasicBlock *>> Visited;

  // Clear all tracking parameters
  void clearAll() {
    lattice_map.clear();
    CFGWorklist.clear();
    SSAWorklist.clear();
    Visited.clear();
  }

  void processCFG(size_t cfgIndex);
  void processSSA(size_t ssaIndex);
  void visitInstruction(Instruction &i);
  void visitPhi(PHINode &i, Lattice &curStatus);
  void visitBranch(BranchInst &i, Lattice &curStatus);
  void visitFoldable(Instruction &i, Lattice &curStatus);
 public:
  int NumInstRemoved;
  int NumDeadBlocks;
  int NumInstReplaced;
};
} // namespace

#endif // INCLUDE_UNIT_SCCP_H
