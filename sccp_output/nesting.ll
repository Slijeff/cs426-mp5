; ModuleID = './mp5_testcases_ll/nesting.ll'
source_filename = "./mp5_testcases/nesting.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0) #0 {
  %2 = icmp slt i32 0, %0
  br i1 %2, label %.lr.ph8, label %16

.lr.ph8:                                          ; preds = %1
  br label %3

3:                                                ; preds = %14, %.lr.ph8
  %.06 = phi i32 [ %0, %.lr.ph8 ], [ %7, %14 ]
  %4 = call i32 @rand() #2
  %5 = srem i32 %4, 7
  %6 = sub nsw i32 %5, 4
  %7 = add nsw i32 %.06, %6
  br label %8

8:                                                ; preds = %3, <null operand!>
  br label %14

.lr.ph:                                           ; preds = <badref>
  br label %9

9:                                                ; preds = %9, %.lr.ph
  %.14 = phi i32 [ %6, %.lr.ph ], [ %11, %9 ]
  %.023 = phi i32 [ 1, %.lr.ph ], [ %10, %9 ]
  %10 = mul nsw i32 %.023, 3
  %11 = mul nsw i32 %.14, 4
  %12 = icmp slt i32 %11, %10
  br i1 %12, label %9, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %9
  %split = phi i32 [ %11, %9 ]
  br label %13

13:                                               ; preds = %._crit_edge, <badref>
  %.1.lcssa = phi i32 [ %split, %._crit_edge ], [ %6, <badref> ]
  br label %14

14:                                               ; preds = %13, %8
  %15 = icmp slt i32 0, %7
  br i1 %15, label %3, label %._crit_edge9, !llvm.loop !8

._crit_edge9:                                     ; preds = %14
  br label %16

16:                                               ; preds = %._crit_edge9, %1
  ret i32 1
}

; Function Attrs: nounwind
declare i32 @rand() #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind }

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
