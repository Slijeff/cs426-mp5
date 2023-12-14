; ModuleID = './mp5_testcases_ll/spectral-norm.ll'
source_filename = "./mp5_testcases/spectral-norm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"%0.9f\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local double @eval_A(i32 noundef %0, i32 noundef %1) #0 {
  %3 = add nsw i32 %0, %1
  %4 = add nsw i32 %0, %1
  %5 = add nsw i32 %4, 1
  %6 = mul nsw i32 %3, %5
  %7 = sdiv i32 %6, 2
  %8 = add nsw i32 %7, %0
  %9 = add nsw i32 %8, 1
  %10 = sitofp i32 %9 to double
  %11 = fdiv double 1.000000e+00, %10
  ret double %11
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @eval_A_times_u(i32 noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = icmp slt i32 0, %0
  br i1 %4, label %.lr.ph5, label %25

.lr.ph5:                                          ; preds = %3
  br label %5

5:                                                ; preds = %22, %.lr.ph5
  %.013 = phi i32 [ 0, %.lr.ph5 ], [ %23, %22 ]
  %6 = sext i32 %.013 to i64
  %7 = getelementptr inbounds double, ptr %2, i64 %6
  store double 0.000000e+00, ptr %7, align 8
  %8 = icmp slt i32 0, %0
  br i1 %8, label %.lr.ph, label %21

.lr.ph:                                           ; preds = %5
  br label %9

9:                                                ; preds = %18, %.lr.ph
  %.02 = phi i32 [ 0, %.lr.ph ], [ %19, %18 ]
  %10 = call double @eval_A(i32 noundef %.013, i32 noundef %.02)
  %11 = sext i32 %.02 to i64
  %12 = getelementptr inbounds double, ptr %1, i64 %11
  %13 = load double, ptr %12, align 8
  %14 = sext i32 %.013 to i64
  %15 = getelementptr inbounds double, ptr %2, i64 %14
  %16 = load double, ptr %15, align 8
  %17 = call double @llvm.fmuladd.f64(double %10, double %13, double %16)
  store double %17, ptr %15, align 8
  br label %18

18:                                               ; preds = %9
  %19 = add nsw i32 %.02, 1
  %20 = icmp slt i32 %19, %0
  br i1 %20, label %9, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %18
  br label %21

21:                                               ; preds = %._crit_edge, %5
  br label %22

22:                                               ; preds = %21
  %23 = add nsw i32 %.013, 1
  %24 = icmp slt i32 %23, %0
  br i1 %24, label %5, label %._crit_edge6, !llvm.loop !8

._crit_edge6:                                     ; preds = %22
  br label %25

25:                                               ; preds = %._crit_edge6, %3
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: noinline nounwind uwtable
define dso_local void @eval_At_times_u(i32 noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = icmp slt i32 0, %0
  br i1 %4, label %.lr.ph5, label %25

.lr.ph5:                                          ; preds = %3
  br label %5

5:                                                ; preds = %22, %.lr.ph5
  %.013 = phi i32 [ 0, %.lr.ph5 ], [ %23, %22 ]
  %6 = sext i32 %.013 to i64
  %7 = getelementptr inbounds double, ptr %2, i64 %6
  store double 0.000000e+00, ptr %7, align 8
  %8 = icmp slt i32 0, %0
  br i1 %8, label %.lr.ph, label %21

.lr.ph:                                           ; preds = %5
  br label %9

9:                                                ; preds = %18, %.lr.ph
  %.02 = phi i32 [ 0, %.lr.ph ], [ %19, %18 ]
  %10 = call double @eval_A(i32 noundef %.02, i32 noundef %.013)
  %11 = sext i32 %.02 to i64
  %12 = getelementptr inbounds double, ptr %1, i64 %11
  %13 = load double, ptr %12, align 8
  %14 = sext i32 %.013 to i64
  %15 = getelementptr inbounds double, ptr %2, i64 %14
  %16 = load double, ptr %15, align 8
  %17 = call double @llvm.fmuladd.f64(double %10, double %13, double %16)
  store double %17, ptr %15, align 8
  br label %18

18:                                               ; preds = %9
  %19 = add nsw i32 %.02, 1
  %20 = icmp slt i32 %19, %0
  br i1 %20, label %9, label %._crit_edge, !llvm.loop !9

._crit_edge:                                      ; preds = %18
  br label %21

21:                                               ; preds = %._crit_edge, %5
  br label %22

22:                                               ; preds = %21
  %23 = add nsw i32 %.013, 1
  %24 = icmp slt i32 %23, %0
  br i1 %24, label %5, label %._crit_edge6, !llvm.loop !10

._crit_edge6:                                     ; preds = %22
  br label %25

25:                                               ; preds = %._crit_edge6, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @eval_AtA_times_u(i32 noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = zext i32 %0 to i64
  %5 = call ptr @llvm.stacksave()
  %6 = alloca double, i64 %4, align 16
  call void @eval_A_times_u(i32 noundef %0, ptr noundef %1, ptr noundef %6)
  call void @eval_At_times_u(i32 noundef %0, ptr noundef %6, ptr noundef %2)
  call void @llvm.stackrestore(ptr %5)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare ptr @llvm.stacksave() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore(ptr) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = icmp eq i32 %0, 2
  br i1 %3, label %4, label %8

4:                                                ; preds = %2
  %5 = getelementptr inbounds ptr, ptr %1, i64 1
  %6 = load ptr, ptr %5, align 8
  %7 = call i32 @atoi(ptr noundef %6) #6
  br label %9

8:                                                ; preds = %2
  br label %9

9:                                                ; preds = %8, %4
  %10 = phi i32 [ %7, %4 ], [ 2000, %8 ]
  %11 = zext i32 %10 to i64
  %12 = call ptr @llvm.stacksave()
  %13 = alloca double, i64 %11, align 16
  %14 = zext i32 %10 to i64
  %15 = alloca double, i64 %14, align 16
  %16 = icmp slt i32 0, %10
  br i1 %16, label %.lr.ph, label %23

.lr.ph:                                           ; preds = %9
  br label %17

17:                                               ; preds = %20, %.lr.ph
  %.023 = phi i32 [ 0, %.lr.ph ], [ %21, %20 ]
  %18 = sext i32 %.023 to i64
  %19 = getelementptr inbounds double, ptr %13, i64 %18
  store double 1.000000e+00, ptr %19, align 8
  br label %20

20:                                               ; preds = %17
  %21 = add nsw i32 %.023, 1
  %22 = icmp slt i32 %21, %10
  br i1 %22, label %17, label %._crit_edge, !llvm.loop !11

._crit_edge:                                      ; preds = %20
  br label %23

23:                                               ; preds = %._crit_edge, %9
  br label %24

24:                                               ; preds = %25, %23
  %.14 = phi i32 [ 0, %23 ], [ %26, %25 ]
  call void @eval_AtA_times_u(i32 noundef %10, ptr noundef %13, ptr noundef %15)
  call void @eval_AtA_times_u(i32 noundef %10, ptr noundef %15, ptr noundef %13)
  br label %25

25:                                               ; preds = %24
  %26 = add nsw i32 %.14, 1
  %27 = icmp slt i32 %26, 10
  br i1 %27, label %24, label %28, !llvm.loop !12

28:                                               ; preds = %25
  %29 = icmp slt i32 0, %10
  br i1 %29, label %.lr.ph9, label %48

.lr.ph9:                                          ; preds = %28
  br label %30

30:                                               ; preds = %45, %.lr.ph9
  %.07 = phi double [ 0.000000e+00, %.lr.ph9 ], [ %44, %45 ]
  %.016 = phi double [ 0.000000e+00, %.lr.ph9 ], [ %37, %45 ]
  %.25 = phi i32 [ 0, %.lr.ph9 ], [ %46, %45 ]
  %31 = sext i32 %.25 to i64
  %32 = getelementptr inbounds double, ptr %13, i64 %31
  %33 = load double, ptr %32, align 8
  %34 = sext i32 %.25 to i64
  %35 = getelementptr inbounds double, ptr %15, i64 %34
  %36 = load double, ptr %35, align 8
  %37 = call double @llvm.fmuladd.f64(double %33, double %36, double %.016)
  %38 = sext i32 %.25 to i64
  %39 = getelementptr inbounds double, ptr %15, i64 %38
  %40 = load double, ptr %39, align 8
  %41 = sext i32 %.25 to i64
  %42 = getelementptr inbounds double, ptr %15, i64 %41
  %43 = load double, ptr %42, align 8
  %44 = call double @llvm.fmuladd.f64(double %40, double %43, double %.07)
  br label %45

45:                                               ; preds = %30
  %46 = add nsw i32 %.25, 1
  %47 = icmp slt i32 %46, %10
  br i1 %47, label %30, label %._crit_edge10, !llvm.loop !13

._crit_edge10:                                    ; preds = %45
  %split = phi double [ %37, %45 ]
  %split11 = phi double [ %44, %45 ]
  br label %48

48:                                               ; preds = %._crit_edge10, %28
  %.01.lcssa = phi double [ %split, %._crit_edge10 ], [ 0.000000e+00, %28 ]
  %.0.lcssa = phi double [ %split11, %._crit_edge10 ], [ 0.000000e+00, %28 ]
  %49 = fdiv double %.01.lcssa, %.0.lcssa
  %50 = call double @sqrt(double noundef %49) #7
  %51 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %50)
  call void @llvm.stackrestore(ptr %12)
  ret i32 0
}

; Function Attrs: nounwind readonly willreturn
declare i32 @atoi(ptr noundef) #3

declare i32 @printf(ptr noundef, ...) #4

; Function Attrs: nounwind
declare double @sqrt(double noundef) #5

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nocallback nofree nosync nounwind willreturn }
attributes #3 = { nounwind readonly willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind readonly willreturn }
attributes #7 = { nounwind }

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
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
