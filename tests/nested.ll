; ModuleID = './tests/nested.ll'
source_filename = "./tests/nested.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  br label %1

1:                                                ; preds = %0, %11
  %.014 = phi i32 [ 0, %0 ], [ %12, %11 ]
  %2 = add nsw i32 0, 1
  %3 = mul nsw i32 %2, 5
  br label %4

4:                                                ; preds = %1, %7
  %.03 = phi i32 [ 0, %1 ], [ %8, %7 ]
  %5 = mul nsw i32 5, %3
  %6 = mul nsw i32 %5, %2
  br label %7

7:                                                ; preds = %4
  %8 = add nsw i32 %.03, 1
  %9 = icmp slt i32 %8, 10
  br i1 %9, label %4, label %10, !llvm.loop !6

10:                                               ; preds = %7
  %.1.lcssa = phi i32 [ %6, %7 ]
  br label %11

11:                                               ; preds = %10
  %12 = add nsw i32 %.014, 1
  %13 = icmp slt i32 %12, 10
  br i1 %13, label %1, label %14, !llvm.loop !8

14:                                               ; preds = %11
  %.02.lcssa = phi i32 [ %.1.lcssa, %11 ]
  ret i32 %.02.lcssa
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 15.0.7"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
