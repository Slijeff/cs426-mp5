; ModuleID = './mp5_testcases_ll/random.ll'
source_filename = "./mp5_testcases/random.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0) #0 {
  %2 = icmp slt i32 0, %0
  br i1 %2, label %.lr.ph, label %13

.lr.ph:                                           ; preds = %1
  br label %3

3:                                                ; preds = %.lr.ph, %11
  %.03 = phi i32 [ %0, %.lr.ph ], [ %8, %11 ]
  %.012 = phi i32 [ 1, %.lr.ph ], [ %.1, %11 ]
  %4 = call i32 @rand() #2
  %5 = srem i32 %4, 4
  %6 = add nsw i32 1, %.012
  %7 = sub nsw i32 %5, %6
  %8 = add nsw i32 %.03, %7
  %9 = icmp sgt i32 %.012, 0
  br i1 %9, label %10, label %11

10:                                               ; preds = %3
  br label %11

11:                                               ; preds = %10, %3
  %.1 = phi i32 [ %.012, %10 ], [ %7, %3 ]
  %12 = icmp slt i32 0, %8
  br i1 %12, label %3, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %11
  %split = phi i32 [ %.1, %11 ]
  br label %13

13:                                               ; preds = %._crit_edge, %1
  %.01.lcssa = phi i32 [ %split, %._crit_edge ], [ 1, %1 ]
  ret i32 %.01.lcssa
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
