; ModuleID = './mp5_testcases_ll/puzzle.ll'
source_filename = "./mp5_testcases/puzzle.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@next = internal global i64 1, align 8
@.str = private unnamed_addr constant [21 x i8] c"Found duplicate: %d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @rand() #0 {
  %1 = load i64, ptr @next, align 8
  %2 = mul i64 %1, 1103515245
  %3 = add i64 %2, 12345
  store i64 %3, ptr @next, align 8
  %4 = load i64, ptr @next, align 8
  %5 = udiv i64 %4, 65536
  %6 = trunc i64 %5 to i32
  %7 = urem i32 %6, 32767
  %8 = add i32 %7, 1
  ret i32 %8
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @srand(i32 noundef %0) #0 {
  %2 = zext i32 %0 to i64
  store i64 %2, ptr @next, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @randInt(i32 noundef %0, i32 noundef %1) #0 {
  %3 = sub nsw i32 %1, %0
  %4 = add nsw i32 %3, 1
  %5 = sitofp i32 %4 to double
  %6 = call i32 @rand() #4
  %7 = sitofp i32 %6 to double
  %8 = fdiv double %7, 3.276800e+04
  %9 = fmul double %5, %8
  %10 = fptosi double %9 to i32
  %11 = icmp eq i32 %10, %4
  br i1 %11, label %12, label %15

12:                                               ; preds = %2
  %13 = add nsw i32 %10, %0
  %14 = sub nsw i32 %13, 1
  br label %17

15:                                               ; preds = %2
  %16 = add nsw i32 %10, %0
  br label %17

17:                                               ; preds = %15, %12
  %18 = phi i32 [ %14, %12 ], [ %16, %15 ]
  ret i32 %18
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @shuffle(ptr noundef %0, i32 noundef %1) #0 {
  %3 = sub nsw i32 %1, 1
  %4 = sext i32 %3 to i64
  %5 = icmp ugt i64 %4, 0
  br i1 %5, label %.lr.ph, label %31

.lr.ph:                                           ; preds = %2
  br label %6

6:                                                ; preds = %.lr.ph, %28
  %.01 = phi i64 [ %4, %.lr.ph ], [ %29, %28 ]
  %7 = add i64 %.01, 1
  %8 = uitofp i64 %7 to double
  %9 = call i32 @rand() #4
  %10 = sitofp i32 %9 to double
  %11 = fdiv double %10, 3.276800e+04
  %12 = fmul double %8, %11
  %13 = fptosi double %12 to i32
  %14 = sext i32 %13 to i64
  %15 = add i64 %.01, 1
  %16 = icmp eq i64 %14, %15
  br i1 %16, label %17, label %19

17:                                               ; preds = %6
  %18 = sub i64 %14, 1
  br label %20

19:                                               ; preds = %6
  br label %20

20:                                               ; preds = %19, %17
  %21 = phi i64 [ %18, %17 ], [ %14, %19 ]
  %22 = getelementptr inbounds i32, ptr %0, i64 %.01
  %23 = load i32, ptr %22, align 4
  %24 = getelementptr inbounds i32, ptr %0, i64 %21
  %25 = load i32, ptr %24, align 4
  %26 = getelementptr inbounds i32, ptr %0, i64 %.01
  store i32 %25, ptr %26, align 4
  %27 = getelementptr inbounds i32, ptr %0, i64 %21
  store i32 %23, ptr %27, align 4
  br label %28

28:                                               ; preds = %20
  %29 = add i64 %.01, -1
  %30 = icmp ugt i64 %29, 0
  br i1 %30, label %6, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %28
  br label %31

31:                                               ; preds = %._crit_edge, %2
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local ptr @createRandomArray(i32 noundef %0) #0 {
  %2 = add nsw i32 %0, 1
  %3 = sext i32 %2 to i64
  %4 = mul i64 %3, 4
  %5 = call noalias ptr @malloc(i64 noundef %4) #5
  %6 = icmp slt i32 0, %2
  br i1 %6, label %.lr.ph, label %13

.lr.ph:                                           ; preds = %1
  br label %7

7:                                                ; preds = %.lr.ph, %10
  %.01 = phi i32 [ 0, %.lr.ph ], [ %11, %10 ]
  %8 = sext i32 %.01 to i64
  %9 = getelementptr inbounds i32, ptr %5, i64 %8
  store i32 %.01, ptr %9, align 4
  br label %10

10:                                               ; preds = %7
  %11 = add nsw i32 %.01, 1
  %12 = icmp slt i32 %11, %2
  br i1 %12, label %7, label %._crit_edge, !llvm.loop !8

._crit_edge:                                      ; preds = %10
  br label %13

13:                                               ; preds = %._crit_edge, %1
  %14 = call i32 @randInt(i32 noundef 1, i32 noundef %0)
  %15 = getelementptr inbounds i32, ptr %5, i64 0
  store i32 %14, ptr %15, align 4
  call void @shuffle(ptr noundef %5, i32 noundef %2)
  ret ptr %5
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @findDuplicate(ptr noundef %0, i32 noundef %1) #0 {
  %3 = icmp slt i32 0, %1
  br i1 %3, label %.lr.ph, label %14

.lr.ph:                                           ; preds = %2
  br label %4

4:                                                ; preds = %.lr.ph, %11
  %.03 = phi i32 [ 0, %.lr.ph ], [ %10, %11 ]
  %.012 = phi i32 [ 0, %.lr.ph ], [ %12, %11 ]
  %5 = add nsw i32 %.012, 1
  %6 = xor i32 %.03, %5
  %7 = sext i32 %.012 to i64
  %8 = getelementptr inbounds i32, ptr %0, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = xor i32 %6, %9
  br label %11

11:                                               ; preds = %4
  %12 = add nsw i32 %.012, 1
  %13 = icmp slt i32 %12, %1
  br i1 %13, label %4, label %._crit_edge, !llvm.loop !9

._crit_edge:                                      ; preds = %11
  %split = phi i32 [ %10, %11 ]
  br label %14

14:                                               ; preds = %._crit_edge, %2
  %.0.lcssa = phi i32 [ %split, %._crit_edge ], [ 0, %2 ]
  %15 = xor i32 %.0.lcssa, %1
  ret i32 %15
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  call void @srand(i32 noundef 1) #4
  br label %1

1:                                                ; preds = %0, %10
  %.014 = phi i32 [ 0, %0 ], [ %11, %10 ]
  %2 = call ptr @createRandomArray(i32 noundef 500000)
  br label %3

3:                                                ; preds = %1, %5
  %.023 = phi i32 [ 0, %1 ], [ %6, %5 ]
  %4 = call i32 @findDuplicate(ptr noundef %2, i32 noundef 500001)
  br label %5

5:                                                ; preds = %3
  %6 = add nsw i32 %.023, 1
  %7 = icmp slt i32 %6, 200
  br i1 %7, label %3, label %8, !llvm.loop !10

8:                                                ; preds = %5
  %.1.lcssa = phi i32 [ %4, %5 ]
  call void @free(ptr noundef %2) #4
  %9 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %.1.lcssa)
  br label %10

10:                                               ; preds = %8
  %11 = add nsw i32 %.014, 1
  %12 = icmp slt i32 %11, 5
  br i1 %12, label %1, label %13, !llvm.loop !11

13:                                               ; preds = %10
  ret i32 0
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #2

declare i32 @printf(ptr noundef, ...) #3

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }
attributes #5 = { nounwind allocsize(0) }

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
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
