; ModuleID = './mp5_testcases_ll/n-body.ll'
source_filename = "./mp5_testcases/n-body.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.planet = type { double, double, double, double, double, double, double }

@bodies = dso_local global [5 x %struct.planet] [%struct.planet { double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 0x4043BD3CC9BE45DE }, %struct.planet { double 0x40135DA0343CD92C, double 0xBFF290ABC01FDB7C, double 0xBFBA86F96C25EBF0, double 0x3FE367069B93CCBC, double 0x40067EF2F57D949B, double 0xBF99D2D79A5A0715, double 0x3FA34C95D9AB33D8 }, %struct.planet { double 0x4020AFCDC332CA67, double 0x40107FCB31DE01B0, double 0xBFD9D353E1EB467C, double 0xBFF02C21B8879442, double 0x3FFD35E9BF1F8F13, double 0x3F813C485F1123B4, double 0x3F871D490D07C637 }, %struct.planet { double 0x4029C9EACEA7D9CF, double 0xC02E38E8D626667E, double 0xBFCC9557BE257DA0, double 0x3FF1531CA9911BEF, double 0x3FEBCC7F3E54BBC5, double 0xBF862F6BFAF23E7C, double 0x3F5C3DD29CF41EB3 }, %struct.planet { double 0x402EC267A905572A, double 0xC039EB5833C8A220, double 0x3FC6F1F393ABE540, double 0x3FEF54B61659BC4A, double 0x3FE307C631C4FBA3, double 0xBFA1CB88587665F6, double 0x3F60A8F3531799AC }], align 16
@.str = private unnamed_addr constant [6 x i8] c"%.9f\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @advance(i32 noundef %0, ptr noundef %1, double noundef %2) #0 {
  %4 = icmp slt i32 0, %0
  br i1 %4, label %.lr.ph5, label %81

.lr.ph5:                                          ; preds = %3
  br label %5

5:                                                ; preds = %.lr.ph5, %78
  %.013 = phi i32 [ 0, %.lr.ph5 ], [ %79, %78 ]
  %6 = sext i32 %.013 to i64
  %7 = getelementptr inbounds %struct.planet, ptr %1, i64 %6
  %8 = add nsw i32 %.013, 1
  %9 = icmp slt i32 %8, %0
  br i1 %9, label %.lr.ph, label %77

.lr.ph:                                           ; preds = %5
  br label %10

10:                                               ; preds = %.lr.ph, %74
  %.02 = phi i32 [ %8, %.lr.ph ], [ %75, %74 ]
  %11 = sext i32 %.02 to i64
  %12 = getelementptr inbounds %struct.planet, ptr %1, i64 %11
  %13 = getelementptr inbounds %struct.planet, ptr %7, i32 0, i32 0
  %14 = load double, ptr %13, align 8
  %15 = getelementptr inbounds %struct.planet, ptr %12, i32 0, i32 0
  %16 = load double, ptr %15, align 8
  %17 = fsub double %14, %16
  %18 = getelementptr inbounds %struct.planet, ptr %7, i32 0, i32 1
  %19 = load double, ptr %18, align 8
  %20 = getelementptr inbounds %struct.planet, ptr %12, i32 0, i32 1
  %21 = load double, ptr %20, align 8
  %22 = fsub double %19, %21
  %23 = getelementptr inbounds %struct.planet, ptr %7, i32 0, i32 2
  %24 = load double, ptr %23, align 8
  %25 = getelementptr inbounds %struct.planet, ptr %12, i32 0, i32 2
  %26 = load double, ptr %25, align 8
  %27 = fsub double %24, %26
  %28 = fmul double %22, %22
  %29 = call double @llvm.fmuladd.f64(double %17, double %17, double %28)
  %30 = call double @llvm.fmuladd.f64(double %27, double %27, double %29)
  %31 = call double @sqrt(double noundef %30) #4
  %32 = fmul double %31, %31
  %33 = fmul double %32, %31
  %34 = fdiv double %2, %33
  %35 = getelementptr inbounds %struct.planet, ptr %12, i32 0, i32 6
  %36 = load double, ptr %35, align 8
  %37 = fmul double %17, %36
  %38 = getelementptr inbounds %struct.planet, ptr %7, i32 0, i32 3
  %39 = load double, ptr %38, align 8
  %40 = fneg double %37
  %41 = call double @llvm.fmuladd.f64(double %40, double %34, double %39)
  store double %41, ptr %38, align 8
  %42 = getelementptr inbounds %struct.planet, ptr %12, i32 0, i32 6
  %43 = load double, ptr %42, align 8
  %44 = fmul double %22, %43
  %45 = getelementptr inbounds %struct.planet, ptr %7, i32 0, i32 4
  %46 = load double, ptr %45, align 8
  %47 = fneg double %44
  %48 = call double @llvm.fmuladd.f64(double %47, double %34, double %46)
  store double %48, ptr %45, align 8
  %49 = getelementptr inbounds %struct.planet, ptr %12, i32 0, i32 6
  %50 = load double, ptr %49, align 8
  %51 = fmul double %27, %50
  %52 = getelementptr inbounds %struct.planet, ptr %7, i32 0, i32 5
  %53 = load double, ptr %52, align 8
  %54 = fneg double %51
  %55 = call double @llvm.fmuladd.f64(double %54, double %34, double %53)
  store double %55, ptr %52, align 8
  %56 = getelementptr inbounds %struct.planet, ptr %7, i32 0, i32 6
  %57 = load double, ptr %56, align 8
  %58 = fmul double %17, %57
  %59 = getelementptr inbounds %struct.planet, ptr %12, i32 0, i32 3
  %60 = load double, ptr %59, align 8
  %61 = call double @llvm.fmuladd.f64(double %58, double %34, double %60)
  store double %61, ptr %59, align 8
  %62 = getelementptr inbounds %struct.planet, ptr %7, i32 0, i32 6
  %63 = load double, ptr %62, align 8
  %64 = fmul double %22, %63
  %65 = getelementptr inbounds %struct.planet, ptr %12, i32 0, i32 4
  %66 = load double, ptr %65, align 8
  %67 = call double @llvm.fmuladd.f64(double %64, double %34, double %66)
  store double %67, ptr %65, align 8
  %68 = getelementptr inbounds %struct.planet, ptr %7, i32 0, i32 6
  %69 = load double, ptr %68, align 8
  %70 = fmul double %27, %69
  %71 = getelementptr inbounds %struct.planet, ptr %12, i32 0, i32 5
  %72 = load double, ptr %71, align 8
  %73 = call double @llvm.fmuladd.f64(double %70, double %34, double %72)
  store double %73, ptr %71, align 8
  br label %74

74:                                               ; preds = %10
  %75 = add nsw i32 %.02, 1
  %76 = icmp slt i32 %75, %0
  br i1 %76, label %10, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %74
  br label %77

77:                                               ; preds = %._crit_edge, %5
  br label %78

78:                                               ; preds = %77
  %79 = add nsw i32 %.013, 1
  %80 = icmp slt i32 %79, %0
  br i1 %80, label %5, label %._crit_edge6, !llvm.loop !8

._crit_edge6:                                     ; preds = %78
  br label %81

81:                                               ; preds = %._crit_edge6, %3
  %82 = icmp slt i32 0, %0
  br i1 %82, label %.lr.ph9, label %104

.lr.ph9:                                          ; preds = %81
  br label %83

83:                                               ; preds = %.lr.ph9, %101
  %.17 = phi i32 [ 0, %.lr.ph9 ], [ %102, %101 ]
  %84 = sext i32 %.17 to i64
  %85 = getelementptr inbounds %struct.planet, ptr %1, i64 %84
  %86 = getelementptr inbounds %struct.planet, ptr %85, i32 0, i32 3
  %87 = load double, ptr %86, align 8
  %88 = getelementptr inbounds %struct.planet, ptr %85, i32 0, i32 0
  %89 = load double, ptr %88, align 8
  %90 = call double @llvm.fmuladd.f64(double %2, double %87, double %89)
  store double %90, ptr %88, align 8
  %91 = getelementptr inbounds %struct.planet, ptr %85, i32 0, i32 4
  %92 = load double, ptr %91, align 8
  %93 = getelementptr inbounds %struct.planet, ptr %85, i32 0, i32 1
  %94 = load double, ptr %93, align 8
  %95 = call double @llvm.fmuladd.f64(double %2, double %92, double %94)
  store double %95, ptr %93, align 8
  %96 = getelementptr inbounds %struct.planet, ptr %85, i32 0, i32 5
  %97 = load double, ptr %96, align 8
  %98 = getelementptr inbounds %struct.planet, ptr %85, i32 0, i32 2
  %99 = load double, ptr %98, align 8
  %100 = call double @llvm.fmuladd.f64(double %2, double %97, double %99)
  store double %100, ptr %98, align 8
  br label %101

101:                                              ; preds = %83
  %102 = add nsw i32 %.17, 1
  %103 = icmp slt i32 %102, %0
  br i1 %103, label %83, label %._crit_edge10, !llvm.loop !9

._crit_edge10:                                    ; preds = %101
  br label %104

104:                                              ; preds = %._crit_edge10, %81
  ret void
}

; Function Attrs: nounwind
declare double @sqrt(double noundef) #1

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #2

; Function Attrs: noinline nounwind uwtable
define dso_local double @energy(i32 noundef %0, ptr noundef %1) #0 {
  %3 = icmp slt i32 0, %0
  br i1 %3, label %.lr.ph8, label %64

.lr.ph8:                                          ; preds = %2
  br label %4

4:                                                ; preds = %.lr.ph8, %61
  %.016 = phi i32 [ 0, %.lr.ph8 ], [ %62, %61 ]
  %.025 = phi double [ 0.000000e+00, %.lr.ph8 ], [ %.1.lcssa, %61 ]
  %5 = sext i32 %.016 to i64
  %6 = getelementptr inbounds %struct.planet, ptr %1, i64 %5
  %7 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 6
  %8 = load double, ptr %7, align 8
  %9 = fmul double 5.000000e-01, %8
  %10 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 3
  %11 = load double, ptr %10, align 8
  %12 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 3
  %13 = load double, ptr %12, align 8
  %14 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 4
  %15 = load double, ptr %14, align 8
  %16 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 4
  %17 = load double, ptr %16, align 8
  %18 = fmul double %15, %17
  %19 = call double @llvm.fmuladd.f64(double %11, double %13, double %18)
  %20 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 5
  %21 = load double, ptr %20, align 8
  %22 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 5
  %23 = load double, ptr %22, align 8
  %24 = call double @llvm.fmuladd.f64(double %21, double %23, double %19)
  %25 = call double @llvm.fmuladd.f64(double %9, double %24, double %.025)
  %26 = add nsw i32 %.016, 1
  %27 = icmp slt i32 %26, %0
  br i1 %27, label %.lr.ph, label %60

.lr.ph:                                           ; preds = %4
  br label %28

28:                                               ; preds = %.lr.ph, %57
  %.04 = phi i32 [ %26, %.lr.ph ], [ %58, %57 ]
  %.13 = phi double [ %25, %.lr.ph ], [ %56, %57 ]
  %29 = sext i32 %.04 to i64
  %30 = getelementptr inbounds %struct.planet, ptr %1, i64 %29
  %31 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 0
  %32 = load double, ptr %31, align 8
  %33 = getelementptr inbounds %struct.planet, ptr %30, i32 0, i32 0
  %34 = load double, ptr %33, align 8
  %35 = fsub double %32, %34
  %36 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 1
  %37 = load double, ptr %36, align 8
  %38 = getelementptr inbounds %struct.planet, ptr %30, i32 0, i32 1
  %39 = load double, ptr %38, align 8
  %40 = fsub double %37, %39
  %41 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 2
  %42 = load double, ptr %41, align 8
  %43 = getelementptr inbounds %struct.planet, ptr %30, i32 0, i32 2
  %44 = load double, ptr %43, align 8
  %45 = fsub double %42, %44
  %46 = fmul double %40, %40
  %47 = call double @llvm.fmuladd.f64(double %35, double %35, double %46)
  %48 = call double @llvm.fmuladd.f64(double %45, double %45, double %47)
  %49 = call double @sqrt(double noundef %48) #4
  %50 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 6
  %51 = load double, ptr %50, align 8
  %52 = getelementptr inbounds %struct.planet, ptr %30, i32 0, i32 6
  %53 = load double, ptr %52, align 8
  %54 = fmul double %51, %53
  %55 = fdiv double %54, %49
  %56 = fsub double %.13, %55
  br label %57

57:                                               ; preds = %28
  %58 = add nsw i32 %.04, 1
  %59 = icmp slt i32 %58, %0
  br i1 %59, label %28, label %._crit_edge, !llvm.loop !10

._crit_edge:                                      ; preds = %57
  %split = phi double [ %56, %57 ]
  br label %60

60:                                               ; preds = %._crit_edge, %4
  %.1.lcssa = phi double [ %split, %._crit_edge ], [ %25, %4 ]
  br label %61

61:                                               ; preds = %60
  %62 = add nsw i32 %.016, 1
  %63 = icmp slt i32 %62, %0
  br i1 %63, label %4, label %._crit_edge9, !llvm.loop !11

._crit_edge9:                                     ; preds = %61
  %split10 = phi double [ %.1.lcssa, %61 ]
  br label %64

64:                                               ; preds = %._crit_edge9, %2
  %.02.lcssa = phi double [ %split10, %._crit_edge9 ], [ 0.000000e+00, %2 ]
  ret double %.02.lcssa
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @offset_momentum(i32 noundef %0, ptr noundef %1) #0 {
  %3 = icmp slt i32 0, %0
  br i1 %3, label %.lr.ph, label %35

.lr.ph:                                           ; preds = %2
  br label %4

4:                                                ; preds = %.lr.ph, %32
  %.07 = phi i32 [ 0, %.lr.ph ], [ %33, %32 ]
  %.016 = phi double [ 0.000000e+00, %.lr.ph ], [ %31, %32 ]
  %.025 = phi double [ 0.000000e+00, %.lr.ph ], [ %13, %32 ]
  %.034 = phi double [ 0.000000e+00, %.lr.ph ], [ %22, %32 ]
  %5 = sext i32 %.07 to i64
  %6 = getelementptr inbounds %struct.planet, ptr %1, i64 %5
  %7 = getelementptr inbounds %struct.planet, ptr %6, i32 0, i32 3
  %8 = load double, ptr %7, align 8
  %9 = sext i32 %.07 to i64
  %10 = getelementptr inbounds %struct.planet, ptr %1, i64 %9
  %11 = getelementptr inbounds %struct.planet, ptr %10, i32 0, i32 6
  %12 = load double, ptr %11, align 8
  %13 = call double @llvm.fmuladd.f64(double %8, double %12, double %.025)
  %14 = sext i32 %.07 to i64
  %15 = getelementptr inbounds %struct.planet, ptr %1, i64 %14
  %16 = getelementptr inbounds %struct.planet, ptr %15, i32 0, i32 4
  %17 = load double, ptr %16, align 8
  %18 = sext i32 %.07 to i64
  %19 = getelementptr inbounds %struct.planet, ptr %1, i64 %18
  %20 = getelementptr inbounds %struct.planet, ptr %19, i32 0, i32 6
  %21 = load double, ptr %20, align 8
  %22 = call double @llvm.fmuladd.f64(double %17, double %21, double %.034)
  %23 = sext i32 %.07 to i64
  %24 = getelementptr inbounds %struct.planet, ptr %1, i64 %23
  %25 = getelementptr inbounds %struct.planet, ptr %24, i32 0, i32 5
  %26 = load double, ptr %25, align 8
  %27 = sext i32 %.07 to i64
  %28 = getelementptr inbounds %struct.planet, ptr %1, i64 %27
  %29 = getelementptr inbounds %struct.planet, ptr %28, i32 0, i32 6
  %30 = load double, ptr %29, align 8
  %31 = call double @llvm.fmuladd.f64(double %26, double %30, double %.016)
  br label %32

32:                                               ; preds = %4
  %33 = add nsw i32 %.07, 1
  %34 = icmp slt i32 %33, %0
  br i1 %34, label %4, label %._crit_edge, !llvm.loop !12

._crit_edge:                                      ; preds = %32
  %split = phi double [ %22, %32 ]
  %split8 = phi double [ %13, %32 ]
  %split9 = phi double [ %31, %32 ]
  br label %35

35:                                               ; preds = %._crit_edge, %2
  %.03.lcssa = phi double [ %split, %._crit_edge ], [ 0.000000e+00, %2 ]
  %.02.lcssa = phi double [ %split8, %._crit_edge ], [ 0.000000e+00, %2 ]
  %.01.lcssa = phi double [ %split9, %._crit_edge ], [ 0.000000e+00, %2 ]
  %36 = fneg double %.02.lcssa
  %37 = fdiv double %36, 0x4043BD3CC9BE45DE
  %38 = getelementptr inbounds %struct.planet, ptr %1, i64 0
  %39 = getelementptr inbounds %struct.planet, ptr %38, i32 0, i32 3
  store double %37, ptr %39, align 8
  %40 = fneg double %.03.lcssa
  %41 = fdiv double %40, 0x4043BD3CC9BE45DE
  %42 = getelementptr inbounds %struct.planet, ptr %1, i64 0
  %43 = getelementptr inbounds %struct.planet, ptr %42, i32 0, i32 4
  store double %41, ptr %43, align 8
  %44 = fneg double %.01.lcssa
  %45 = fdiv double %44, 0x4043BD3CC9BE45DE
  %46 = getelementptr inbounds %struct.planet, ptr %1, i64 0
  %47 = getelementptr inbounds %struct.planet, ptr %46, i32 0, i32 5
  store double %45, ptr %47, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  call void @offset_momentum(i32 noundef 5, ptr noundef @bodies)
  %3 = call double @energy(i32 noundef 5, ptr noundef @bodies)
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %3)
  br label %5

5:                                                ; preds = %2, %6
  %.01 = phi i32 [ 1, %2 ], [ %7, %6 ]
  call void @advance(i32 noundef 5, ptr noundef @bodies, double noundef 1.000000e-02)
  br label %6

6:                                                ; preds = %5
  %7 = add nsw i32 %.01, 1
  %8 = icmp sle i32 %7, 5000000
  br i1 %8, label %5, label %9, !llvm.loop !13

9:                                                ; preds = %6
  %10 = call double @energy(i32 noundef 5, ptr noundef @bodies)
  %11 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %10)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #3

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

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
