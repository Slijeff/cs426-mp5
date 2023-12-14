; ModuleID = './mp5_testcases_ll/partialsums.ll'
source_filename = "./mp5_testcases/partialsums.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"%.9f\09%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"(2/3)^k\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"k^-0.5\00", align 1
@.str.3 = private unnamed_addr constant [9 x i8] c"1/k(k+1)\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"Flint Hills\00", align 1
@.str.5 = private unnamed_addr constant [14 x i8] c"Cookson Hills\00", align 1
@.str.6 = private unnamed_addr constant [9 x i8] c"Harmonic\00", align 1
@.str.7 = private unnamed_addr constant [13 x i8] c"Riemann Zeta\00", align 1
@.str.8 = private unnamed_addr constant [21 x i8] c"Alternating Harmonic\00", align 1
@.str.9 = private unnamed_addr constant [8 x i8] c"Gregory\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local <2 x double> @make_vec(double noundef %0, double noundef %1) #0 {
  %3 = alloca <2 x double>, align 16
  store double %0, ptr %3, align 8
  %4 = getelementptr inbounds double, ptr %3, i64 1
  store double %1, ptr %4, align 8
  %5 = load <2 x double>, ptr %3, align 16
  ret <2 x double> %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local double @sum_vec(<2 x double> noundef %0) #0 {
  %2 = alloca <2 x double>, align 16
  store <2 x double> %0, ptr %2, align 16
  %3 = load double, ptr %2, align 8
  %4 = getelementptr inbounds double, ptr %2, i64 1
  %5 = load double, ptr %4, align 8
  %6 = fadd double %3, %5
  ret double %6
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca <2 x double>, align 16
  %4 = call <2 x double> @make_vec(double noundef 0.000000e+00, double noundef 0.000000e+00)
  %5 = call <2 x double> @make_vec(double noundef 1.000000e+00, double noundef 1.000000e+00)
  %6 = call <2 x double> @make_vec(double noundef 2.000000e+00, double noundef 2.000000e+00)
  %7 = call <2 x double> @make_vec(double noundef -1.000000e+00, double noundef -1.000000e+00)
  %8 = call <2 x double> @make_vec(double noundef 1.000000e+00, double noundef 2.000000e+00)
  %9 = call <2 x double> @make_vec(double noundef 1.000000e+00, double noundef -1.000000e+00)
  %10 = sitofp i32 2500000 to double
  %11 = fcmp ole double 1.000000e+00, %10
  br i1 %11, label %.lr.ph, label %34

.lr.ph:                                           ; preds = %2
  br label %12

12:                                               ; preds = %31, %.lr.ph
  %.014 = phi double [ 1.000000e+00, %.lr.ph ], [ %32, %31 ]
  %.0313 = phi double [ 0.000000e+00, %.lr.ph ], [ %15, %31 ]
  %.0412 = phi double [ 0.000000e+00, %.lr.ph ], [ %18, %31 ]
  %.0511 = phi double [ 0.000000e+00, %.lr.ph ], [ %26, %31 ]
  %.0610 = phi double [ 0.000000e+00, %.lr.ph ], [ %30, %31 ]
  %13 = fsub double %.014, 1.000000e+00
  %14 = call double @pow(double noundef 0x3FE5555555555555, double noundef %13) #4
  %15 = fadd double %.0313, %14
  %16 = call double @sqrt(double noundef %.014) #4
  %17 = fdiv double 1.000000e+00, %16
  %18 = fadd double %.0412, %17
  %19 = fmul double %.014, %.014
  %20 = fmul double %19, %.014
  %21 = call double @sin(double noundef %.014) #4
  %22 = call double @cos(double noundef %.014) #4
  %23 = fmul double %20, %21
  %24 = fmul double %23, %21
  %25 = fdiv double 1.000000e+00, %24
  %26 = fadd double %.0511, %25
  %27 = fmul double %20, %22
  %28 = fmul double %27, %22
  %29 = fdiv double 1.000000e+00, %28
  %30 = fadd double %.0610, %29
  br label %31

31:                                               ; preds = %12
  %32 = fadd double %.014, 1.000000e+00
  %33 = fcmp ole double %32, %10
  br i1 %33, label %12, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %31
  %split = phi double [ %30, %31 ]
  %split15 = phi double [ %26, %31 ]
  %split16 = phi double [ %18, %31 ]
  %split17 = phi double [ %15, %31 ]
  br label %34

34:                                               ; preds = %._crit_edge, %2
  %.06.lcssa = phi double [ %split, %._crit_edge ], [ 0.000000e+00, %2 ]
  %.05.lcssa = phi double [ %split15, %._crit_edge ], [ 0.000000e+00, %2 ]
  %.04.lcssa = phi double [ %split16, %._crit_edge ], [ 0.000000e+00, %2 ]
  %.03.lcssa = phi double [ %split17, %._crit_edge ], [ 0.000000e+00, %2 ]
  store <2 x double> %8, ptr %3, align 16
  %35 = load double, ptr %3, align 16
  %36 = sitofp i32 2500000 to double
  %37 = fcmp ole double %35, %36
  br i1 %37, label %.lr.ph24, label %66

.lr.ph24:                                         ; preds = %34
  br label %38

38:                                               ; preds = %61, %.lr.ph24
  %.0122 = phi <2 x double> [ %4, %.lr.ph24 ], [ %60, %61 ]
  %.0221 = phi <2 x double> [ %4, %.lr.ph24 ], [ %55, %61 ]
  %.0720 = phi <2 x double> [ %4, %.lr.ph24 ], [ %47, %61 ]
  %.0819 = phi <2 x double> [ %4, %.lr.ph24 ], [ %52, %61 ]
  %.0918 = phi <2 x double> [ %4, %.lr.ph24 ], [ %44, %61 ]
  %39 = load <2 x double>, ptr %3, align 16
  %40 = load <2 x double>, ptr %3, align 16
  %41 = fadd <2 x double> %40, %5
  %42 = fmul <2 x double> %39, %41
  %43 = fdiv <2 x double> %5, %42
  %44 = fadd <2 x double> %.0918, %43
  %45 = load <2 x double>, ptr %3, align 16
  %46 = fdiv <2 x double> %5, %45
  %47 = fadd <2 x double> %.0720, %46
  %48 = load <2 x double>, ptr %3, align 16
  %49 = load <2 x double>, ptr %3, align 16
  %50 = fmul <2 x double> %48, %49
  %51 = fdiv <2 x double> %5, %50
  %52 = fadd <2 x double> %.0819, %51
  %53 = load <2 x double>, ptr %3, align 16
  %54 = fdiv <2 x double> %9, %53
  %55 = fadd <2 x double> %.0221, %54
  %56 = load <2 x double>, ptr %3, align 16
  %57 = fneg <2 x double> %5
  %58 = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %6, <2 x double> %56, <2 x double> %57)
  %59 = fdiv <2 x double> %9, %58
  %60 = fadd <2 x double> %.0122, %59
  br label %61

61:                                               ; preds = %38
  %62 = load <2 x double>, ptr %3, align 16
  %63 = fadd <2 x double> %62, %6
  store <2 x double> %63, ptr %3, align 16
  %64 = load double, ptr %3, align 16
  %65 = fcmp ole double %64, %36
  br i1 %65, label %38, label %._crit_edge25, !llvm.loop !8

._crit_edge25:                                    ; preds = %61
  %split26 = phi <2 x double> [ %44, %61 ]
  %split27 = phi <2 x double> [ %52, %61 ]
  %split28 = phi <2 x double> [ %47, %61 ]
  %split29 = phi <2 x double> [ %55, %61 ]
  %split30 = phi <2 x double> [ %60, %61 ]
  br label %66

66:                                               ; preds = %._crit_edge25, %34
  %.09.lcssa = phi <2 x double> [ %split26, %._crit_edge25 ], [ %4, %34 ]
  %.08.lcssa = phi <2 x double> [ %split27, %._crit_edge25 ], [ %4, %34 ]
  %.07.lcssa = phi <2 x double> [ %split28, %._crit_edge25 ], [ %4, %34 ]
  %.02.lcssa = phi <2 x double> [ %split29, %._crit_edge25 ], [ %4, %34 ]
  %.01.lcssa = phi <2 x double> [ %split30, %._crit_edge25 ], [ %4, %34 ]
  %67 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %.03.lcssa, ptr noundef @.str.1)
  %68 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %.04.lcssa, ptr noundef @.str.2)
  %69 = call double @sum_vec(<2 x double> noundef %.09.lcssa)
  %70 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %69, ptr noundef @.str.3)
  %71 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %.05.lcssa, ptr noundef @.str.4)
  %72 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %.06.lcssa, ptr noundef @.str.5)
  %73 = call double @sum_vec(<2 x double> noundef %.07.lcssa)
  %74 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %73, ptr noundef @.str.6)
  %75 = call double @sum_vec(<2 x double> noundef %.08.lcssa)
  %76 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %75, ptr noundef @.str.7)
  %77 = call double @sum_vec(<2 x double> noundef %.02.lcssa)
  %78 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %77, ptr noundef @.str.8)
  %79 = call double @sum_vec(<2 x double> noundef %.01.lcssa)
  %80 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %79, ptr noundef @.str.9)
  ret i32 0
}

; Function Attrs: nounwind
declare double @pow(double noundef, double noundef) #1

; Function Attrs: nounwind
declare double @sqrt(double noundef) #1

; Function Attrs: nounwind
declare double @sin(double noundef) #1

; Function Attrs: nounwind
declare double @cos(double noundef) #1

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #2

declare i32 @printf(ptr noundef, ...) #3

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="128" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
