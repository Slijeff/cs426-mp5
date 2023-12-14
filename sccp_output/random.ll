; ModuleID = './mp5_testcases_ll/random.ll'
source_filename = "./mp5_testcases/random.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0) #0 {
  %2 = icmp slt i32 0, %0
  br i1 %2, label %.lr.ph, label %9

.lr.ph:                                           ; preds = %1
  br label %3

3:                                                ; preds = <badref>, %.lr.ph
  %.03 = phi i32 [ %0, %.lr.ph ], [ %7, <badref> ]
  %4 = call i32 @rand() #2
  %5 = srem i32 %4, 4
  %6 = sub nsw i32 %5, 2
  %7 = add nsw i32 %.03, %6
  br label %8

8:                                                ; preds = %3, <null operand!>
  br label <badref>

._crit_edge:                                      ; preds = <badref>
  br label %9

9:                                                ; preds = %._crit_edge, %1
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
