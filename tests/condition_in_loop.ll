; ModuleID = './tests/condition_in_loop.ll'
source_filename = "./tests/condition_in_loop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  br label %1

1:                                                ; preds = %0, %11
  %.02 = phi i32 [ 0, %0 ], [ %12, %11 ]
  %2 = add nsw i32 0, 1
  %3 = mul nsw i32 %2, 5
  %4 = call i32 @rand() #2
  %5 = srem i32 %4, 100
  %6 = add nsw i32 %5, 1
  %7 = icmp sgt i32 %6, 50
  br i1 %7, label %8, label %9

8:                                                ; preds = %1
  br label %10

9:                                                ; preds = %1
  br label %10

10:                                               ; preds = %9, %8
  %.1 = phi i32 [ 10086, %8 ], [ 114514, %9 ]
  br label %11

11:                                               ; preds = %10
  %12 = add nsw i32 %.02, 1
  %13 = icmp slt i32 %12, 10
  br i1 %13, label %1, label %14, !llvm.loop !6

14:                                               ; preds = %11
  %.01.lcssa = phi i32 [ %.1, %11 ]
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
