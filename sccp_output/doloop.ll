; ModuleID = './mp5_testcases_ll/doloop.ll'
source_filename = "./mp5_testcases/doloop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0, ptr noalias noundef %1, ptr noalias noundef %2) #0 {
  br label %4

4:                                                ; preds = %12, %3
  %.0 = phi i32 [ %0, %3 ], [ %9, %12 ]
  br label %5

5:                                                ; preds = %4, <null operand!>
  store i32 %0, ptr %1, align 4
  br label %6

6:                                                ; preds = %5, <null operand!>
  %7 = sdiv i32 %0, -3
  %8 = sub nsw i32 %7, 2
  %9 = add nsw i32 %.0, %8
  br label %10

10:                                               ; preds = %6, <null operand!>
  br label %11

11:                                               ; preds = %10, <null operand!>
  store i32 %0, ptr %2, align 4
  br label %12

12:                                               ; preds = %11
  %13 = icmp slt i32 0, %9
  br i1 %13, label %4, label %14, !llvm.loop !6

14:                                               ; preds = %12
  ret i32 1
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