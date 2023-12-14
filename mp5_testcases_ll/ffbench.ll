; ModuleID = './mp5_testcases_ll/ffbench.ll'
source_filename = "./mp5_testcases/ffbench.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@main.nsize = internal global [3 x i32] zeroinitializer, align 4
@stderr = external global ptr, align 8
@.str = private unnamed_addr constant [28 x i8] c"Can't allocate data array.\0A\00", align 1
@.str.1 = private unnamed_addr constant [48 x i8] c"Wrong answer at (%d,%d)!  Expected %d, got %d.\0A\00", align 1
@.str.2 = private unnamed_addr constant [35 x i8] c"%d passes.  No errors in results.\0A\00", align 1
@.str.3 = private unnamed_addr constant [35 x i8] c"%d passes.  %d errors in results.\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = mul nsw i32 256, 256
  %2 = sext i32 %1 to i64
  %3 = add nsw i64 %2, 1
  %4 = mul nsw i64 %3, 2
  %5 = mul i64 %4, 8
  store i32 256, ptr getelementptr inbounds ([3 x i32], ptr @main.nsize, i64 0, i64 2), align 4
  store i32 256, ptr getelementptr inbounds ([3 x i32], ptr @main.nsize, i64 0, i64 1), align 4
  %6 = call noalias ptr @malloc(i64 noundef %5) #7
  %7 = icmp eq ptr %6, null
  br i1 %7, label %8, label %11

8:                                                ; preds = %0
  %9 = load ptr, ptr @stderr, align 8
  %10 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %9, ptr noundef @.str)
  call void @exit(i32 noundef 1) #8
  unreachable

11:                                               ; preds = %0
  call void @llvm.memset.p0.i64(ptr align 8 %6, i8 0, i64 %5, i1 false)
  br label %12

12:                                               ; preds = %11, %31
  %.0114 = phi i32 [ 0, %11 ], [ %32, %31 ]
  br label %13

13:                                               ; preds = %12, %27
  %.0212 = phi i32 [ 0, %12 ], [ %28, %27 ]
  %14 = and i32 %.0114, 15
  %15 = icmp eq i32 %14, 8
  br i1 %15, label %19, label %16

16:                                               ; preds = %13
  %17 = and i32 %.0212, 15
  %18 = icmp eq i32 %17, 8
  br i1 %18, label %19, label %26

19:                                               ; preds = %16, %13
  %20 = mul nsw i32 256, %.0114
  %21 = add nsw i32 %20, %.0212
  %22 = mul nsw i32 %21, 2
  %23 = add nsw i32 1, %22
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds double, ptr %6, i64 %24
  store double 1.280000e+02, ptr %25, align 8
  br label %26

26:                                               ; preds = %19, %16
  %.0213 = phi i32 [ %.0212, %19 ], [ %.0212, %16 ]
  br label %27

27:                                               ; preds = %26
  %28 = add nsw i32 %.0213, 1
  %29 = icmp slt i32 %28, 256
  br i1 %29, label %13, label %30, !llvm.loop !6

30:                                               ; preds = %27
  br label %31

31:                                               ; preds = %30
  %32 = add nsw i32 %.0114, 1
  %33 = icmp slt i32 %32, 256
  br i1 %33, label %12, label %34, !llvm.loop !8

34:                                               ; preds = %31
  br label %35

35:                                               ; preds = %34, %36
  %.115 = phi i32 [ 0, %34 ], [ %37, %36 ]
  call void @fourn(ptr noundef %6, ptr noundef @main.nsize, i32 noundef 2, i32 noundef 1)
  call void @fourn(ptr noundef %6, ptr noundef @main.nsize, i32 noundef 2, i32 noundef -1)
  br label %36

36:                                               ; preds = %35
  %37 = add nsw i32 %.115, 1
  %38 = icmp slt i32 %37, 63
  br i1 %38, label %35, label %39, !llvm.loop !9

39:                                               ; preds = %36
  %40 = icmp sle i64 1, %2
  br i1 %40, label %.lr.ph, label %75

.lr.ph:                                           ; preds = %39
  br label %41

41:                                               ; preds = %.lr.ph, %71
  %.022 = phi double [ 0.000000e+00, %.lr.ph ], [ %50, %71 ]
  %.221 = phi i32 [ 1, %.lr.ph ], [ %72, %71 ]
  %.0420 = phi double [ 0.000000e+00, %.lr.ph ], [ %49, %71 ]
  %.0519 = phi double [ -1.000000e+10, %.lr.ph ], [ %70, %71 ]
  %.0918 = phi double [ 1.000000e+10, %.lr.ph ], [ %65, %71 ]
  %.01017 = phi double [ -1.000000e+10, %.lr.ph ], [ %60, %71 ]
  %.01116 = phi double [ 1.000000e+10, %.lr.ph ], [ %55, %71 ]
  %42 = sext i32 %.221 to i64
  %43 = getelementptr inbounds double, ptr %6, i64 %42
  %44 = load double, ptr %43, align 8
  %45 = add nsw i32 %.221, 1
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds double, ptr %6, i64 %46
  %48 = load double, ptr %47, align 8
  %49 = fadd double %.0420, %44
  %50 = fadd double %.022, %48
  %51 = fcmp ole double %44, %.01116
  br i1 %51, label %52, label %53

52:                                               ; preds = %41
  br label %54

53:                                               ; preds = %41
  br label %54

54:                                               ; preds = %53, %52
  %55 = phi double [ %44, %52 ], [ %.01116, %53 ]
  %56 = fcmp ogt double %44, %.01017
  br i1 %56, label %57, label %58

57:                                               ; preds = %54
  br label %59

58:                                               ; preds = %54
  br label %59

59:                                               ; preds = %58, %57
  %60 = phi double [ %44, %57 ], [ %.01017, %58 ]
  %61 = fcmp ole double %48, %.0918
  br i1 %61, label %62, label %63

62:                                               ; preds = %59
  br label %64

63:                                               ; preds = %59
  br label %64

64:                                               ; preds = %63, %62
  %65 = phi double [ %48, %62 ], [ %.0918, %63 ]
  %66 = fcmp ogt double %48, %.0519
  br i1 %66, label %67, label %68

67:                                               ; preds = %64
  br label %69

68:                                               ; preds = %64
  br label %69

69:                                               ; preds = %68, %67
  %70 = phi double [ %48, %67 ], [ %.0519, %68 ]
  br label %71

71:                                               ; preds = %69
  %72 = add nsw i32 %.221, 2
  %73 = sext i32 %72 to i64
  %74 = icmp sle i64 %73, %2
  br i1 %74, label %41, label %._crit_edge, !llvm.loop !10

._crit_edge:                                      ; preds = %71
  %split = phi double [ %55, %71 ]
  %split23 = phi double [ %60, %71 ]
  br label %75

75:                                               ; preds = %._crit_edge, %39
  %.011.lcssa = phi double [ %split, %._crit_edge ], [ 1.000000e+10, %39 ]
  %.010.lcssa = phi double [ %split23, %._crit_edge ], [ -1.000000e+10, %39 ]
  %76 = fsub double %.010.lcssa, %.011.lcssa
  %77 = fdiv double 2.550000e+02, %76
  br label %78

78:                                               ; preds = %75, %109
  %.327 = phi i32 [ 0, %75 ], [ %110, %109 ]
  %.0626 = phi i32 [ 0, %75 ], [ %.17.lcssa, %109 ]
  br label %79

79:                                               ; preds = %78, %105
  %.1325 = phi i32 [ 0, %78 ], [ %106, %105 ]
  %.1724 = phi i32 [ %.0626, %78 ], [ %.28, %105 ]
  %80 = mul nsw i32 256, %.327
  %81 = add nsw i32 %80, %.1325
  %82 = mul nsw i32 %81, 2
  %83 = add nsw i32 1, %82
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds double, ptr %6, i64 %84
  %86 = load double, ptr %85, align 8
  %87 = fsub double %86, %.011.lcssa
  %88 = fmul double %87, %77
  %89 = fptosi double %88 to i32
  %90 = and i32 %.327, 15
  %91 = icmp eq i32 %90, 8
  br i1 %91, label %95, label %92

92:                                               ; preds = %79
  %93 = and i32 %.1325, 15
  %94 = icmp eq i32 %93, 8
  br label %95

95:                                               ; preds = %92, %79
  %96 = phi i1 [ true, %79 ], [ %94, %92 ]
  %97 = zext i1 %96 to i64
  %98 = select i1 %96, i32 255, i32 0
  %99 = icmp ne i32 %89, %98
  br i1 %99, label %100, label %104

100:                                              ; preds = %95
  %101 = add nsw i32 %.1724, 1
  %102 = load ptr, ptr @stderr, align 8
  %103 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %102, ptr noundef @.str.1, i32 noundef %.327, i32 noundef %.1325, i32 noundef %98, i32 noundef %89)
  br label %104

104:                                              ; preds = %100, %95
  %.28 = phi i32 [ %101, %100 ], [ %.1724, %95 ]
  br label %105

105:                                              ; preds = %104
  %106 = add nsw i32 %.1325, 1
  %107 = icmp slt i32 %106, 256
  br i1 %107, label %79, label %108, !llvm.loop !11

108:                                              ; preds = %105
  %.17.lcssa = phi i32 [ %.28, %105 ]
  br label %109

109:                                              ; preds = %108
  %110 = add nsw i32 %.327, 1
  %111 = icmp slt i32 %110, 256
  br i1 %111, label %78, label %112, !llvm.loop !12

112:                                              ; preds = %109
  %.06.lcssa = phi i32 [ %.17.lcssa, %109 ]
  %113 = icmp eq i32 %.06.lcssa, 0
  br i1 %113, label %114, label %117

114:                                              ; preds = %112
  %115 = load ptr, ptr @stderr, align 8
  %116 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %115, ptr noundef @.str.2, i32 noundef 63)
  br label %120

117:                                              ; preds = %112
  %118 = load ptr, ptr @stderr, align 8
  %119 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %118, ptr noundef @.str.3, i32 noundef 63, i32 noundef %.06.lcssa)
  br label %120

120:                                              ; preds = %117, %114
  ret i32 0
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

declare i32 @fprintf(ptr noundef, ptr noundef, ...) #2

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #3

; Function Attrs: argmemonly nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: noinline nounwind uwtable
define internal void @fourn(ptr noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = icmp sle i32 1, %2
  br i1 %5, label %.lr.ph, label %14

.lr.ph:                                           ; preds = %4
  br label %6

6:                                                ; preds = %.lr.ph, %11
  %.0916 = phi i32 [ 1, %.lr.ph ], [ %10, %11 ]
  %.01115 = phi i32 [ 1, %.lr.ph ], [ %12, %11 ]
  %7 = sext i32 %.01115 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = mul nsw i32 %.0916, %9
  br label %11

11:                                               ; preds = %6
  %12 = add nsw i32 %.01115, 1
  %13 = icmp sle i32 %12, %2
  br i1 %13, label %6, label %._crit_edge, !llvm.loop !13

._crit_edge:                                      ; preds = %11
  %split = phi i32 [ %10, %11 ]
  br label %14

14:                                               ; preds = %._crit_edge, %4
  %.09.lcssa = phi i32 [ %split, %._crit_edge ], [ 1, %4 ]
  %15 = icmp sge i32 %2, 1
  br i1 %15, label %.lr.ph52, label %175

.lr.ph52:                                         ; preds = %14
  br label %16

16:                                               ; preds = %.lr.ph52, %172
  %.01050 = phi i32 [ 1, %.lr.ph52 ], [ %171, %172 ]
  %.11249 = phi i32 [ %2, %.lr.ph52 ], [ %173, %172 ]
  %17 = sext i32 %.11249 to i64
  %18 = getelementptr inbounds i32, ptr %1, i64 %17
  %19 = load i32, ptr %18, align 4
  %20 = mul nsw i32 %19, %.01050
  %21 = sdiv i32 %.09.lcssa, %20
  %22 = shl i32 %.01050, 1
  %23 = mul nsw i32 %22, %19
  %24 = mul nsw i32 %23, %21
  %25 = icmp sle i32 1, %23
  br i1 %25, label %.lr.ph29, label %85

.lr.ph29:                                         ; preds = %16
  br label %26

26:                                               ; preds = %.lr.ph29, %82
  %.0326 = phi i32 [ 1, %.lr.ph29 ], [ %83, %82 ]
  %.0725 = phi i32 [ 1, %.lr.ph29 ], [ %81, %82 ]
  %27 = icmp slt i32 %.0326, %.0725
  br i1 %27, label %28, label %69

28:                                               ; preds = %26
  %29 = add nsw i32 %.0326, %22
  %30 = sub nsw i32 %29, 2
  %31 = icmp sle i32 %.0326, %30
  br i1 %31, label %.lr.ph23, label %68

.lr.ph23:                                         ; preds = %28
  br label %32

32:                                               ; preds = %.lr.ph23, %65
  %.0221 = phi i32 [ %.0326, %.lr.ph23 ], [ %66, %65 ]
  %33 = icmp sle i32 %.0221, %24
  br i1 %33, label %.lr.ph19, label %64

.lr.ph19:                                         ; preds = %32
  br label %34

34:                                               ; preds = %.lr.ph19, %61
  %.0517 = phi i32 [ %.0221, %.lr.ph19 ], [ %62, %61 ]
  %35 = add nsw i32 %.0725, %.0517
  %36 = sub nsw i32 %35, %.0326
  %37 = sext i32 %.0517 to i64
  %38 = getelementptr inbounds double, ptr %0, i64 %37
  %39 = load double, ptr %38, align 8
  %40 = sext i32 %36 to i64
  %41 = getelementptr inbounds double, ptr %0, i64 %40
  %42 = load double, ptr %41, align 8
  %43 = sext i32 %.0517 to i64
  %44 = getelementptr inbounds double, ptr %0, i64 %43
  store double %42, ptr %44, align 8
  %45 = sext i32 %36 to i64
  %46 = getelementptr inbounds double, ptr %0, i64 %45
  store double %39, ptr %46, align 8
  %47 = add nsw i32 %.0517, 1
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds double, ptr %0, i64 %48
  %50 = load double, ptr %49, align 8
  %51 = add nsw i32 %36, 1
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds double, ptr %0, i64 %52
  %54 = load double, ptr %53, align 8
  %55 = add nsw i32 %.0517, 1
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds double, ptr %0, i64 %56
  store double %54, ptr %57, align 8
  %58 = add nsw i32 %36, 1
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds double, ptr %0, i64 %59
  store double %50, ptr %60, align 8
  br label %61

61:                                               ; preds = %34
  %62 = add nsw i32 %.0517, %23
  %63 = icmp sle i32 %62, %24
  br i1 %63, label %34, label %._crit_edge20, !llvm.loop !14

._crit_edge20:                                    ; preds = %61
  br label %64

64:                                               ; preds = %._crit_edge20, %32
  br label %65

65:                                               ; preds = %64
  %66 = add nsw i32 %.0221, 2
  %67 = icmp sle i32 %66, %30
  br i1 %67, label %32, label %._crit_edge24, !llvm.loop !15

._crit_edge24:                                    ; preds = %65
  br label %68

68:                                               ; preds = %._crit_edge24, %28
  br label %69

69:                                               ; preds = %68, %26
  %.0327 = phi i32 [ %.0326, %68 ], [ %.0326, %26 ]
  %70 = ashr i32 %23, 1
  br label %71

71:                                               ; preds = %77, %69
  %.013 = phi i32 [ %70, %69 ], [ %79, %77 ]
  %.18 = phi i32 [ %.0725, %69 ], [ %78, %77 ]
  %72 = icmp sge i32 %.013, %22
  br i1 %72, label %73, label %75

73:                                               ; preds = %71
  %74 = icmp sgt i32 %.18, %.013
  br label %75

75:                                               ; preds = %73, %71
  %76 = phi i1 [ false, %71 ], [ %74, %73 ]
  br i1 %76, label %77, label %80

77:                                               ; preds = %75
  %78 = sub nsw i32 %.18, %.013
  %79 = ashr i32 %.013, 1
  br label %71, !llvm.loop !16

80:                                               ; preds = %75
  %.013.lcssa = phi i32 [ %.013, %75 ]
  %.18.lcssa = phi i32 [ %.18, %75 ]
  %81 = add nsw i32 %.18.lcssa, %.013.lcssa
  br label %82

82:                                               ; preds = %80
  %83 = add nsw i32 %.0327, %22
  %84 = icmp sle i32 %83, %23
  br i1 %84, label %26, label %._crit_edge30, !llvm.loop !17

._crit_edge30:                                    ; preds = %82
  br label %85

85:                                               ; preds = %._crit_edge30, %16
  %86 = icmp slt i32 %22, %23
  br i1 %86, label %.lr.ph47, label %170

.lr.ph47:                                         ; preds = %85
  br label %87

87:                                               ; preds = %.lr.ph47, %168
  %.01445 = phi i32 [ %22, %.lr.ph47 ], [ %88, %168 ]
  %88 = shl i32 %.01445, 1
  %89 = sitofp i32 %3 to double
  %90 = fmul double %89, 0x401921FB54442D1C
  %91 = sdiv i32 %88, %22
  %92 = sitofp i32 %91 to double
  %93 = fdiv double %90, %92
  %94 = fmul double 5.000000e-01, %93
  %95 = call double @sin(double noundef %94) #9
  %96 = fmul double -2.000000e+00, %95
  %97 = fmul double %96, %95
  %98 = call double @sin(double noundef %93) #9
  %99 = icmp sle i32 1, %.01445
  br i1 %99, label %.lr.ph43, label %168

.lr.ph43:                                         ; preds = %87
  br label %100

100:                                              ; preds = %.lr.ph43, %165
  %.041 = phi double [ 1.000000e+00, %.lr.ph43 ], [ %161, %165 ]
  %.0140 = phi double [ 0.000000e+00, %.lr.ph43 ], [ %164, %165 ]
  %.1639 = phi i32 [ 1, %.lr.ph43 ], [ %166, %165 ]
  %101 = add nsw i32 %.1639, %22
  %102 = sub nsw i32 %101, 2
  %103 = icmp sle i32 %.1639, %102
  br i1 %103, label %.lr.ph37, label %157

.lr.ph37:                                         ; preds = %100
  br label %104

104:                                              ; preds = %.lr.ph37, %154
  %.135 = phi i32 [ %.1639, %.lr.ph37 ], [ %155, %154 ]
  %105 = icmp sle i32 %.135, %24
  br i1 %105, label %.lr.ph33, label %153

.lr.ph33:                                         ; preds = %104
  br label %106

106:                                              ; preds = %.lr.ph33, %150
  %.1431 = phi i32 [ %.135, %.lr.ph33 ], [ %151, %150 ]
  %107 = add nsw i32 %.1431, %.01445
  %108 = sext i32 %107 to i64
  %109 = getelementptr inbounds double, ptr %0, i64 %108
  %110 = load double, ptr %109, align 8
  %111 = add nsw i32 %107, 1
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds double, ptr %0, i64 %112
  %114 = load double, ptr %113, align 8
  %115 = fmul double %.0140, %114
  %116 = fneg double %115
  %117 = call double @llvm.fmuladd.f64(double %.041, double %110, double %116)
  %118 = add nsw i32 %107, 1
  %119 = sext i32 %118 to i64
  %120 = getelementptr inbounds double, ptr %0, i64 %119
  %121 = load double, ptr %120, align 8
  %122 = sext i32 %107 to i64
  %123 = getelementptr inbounds double, ptr %0, i64 %122
  %124 = load double, ptr %123, align 8
  %125 = fmul double %.0140, %124
  %126 = call double @llvm.fmuladd.f64(double %.041, double %121, double %125)
  %127 = sext i32 %.1431 to i64
  %128 = getelementptr inbounds double, ptr %0, i64 %127
  %129 = load double, ptr %128, align 8
  %130 = fsub double %129, %117
  %131 = sext i32 %107 to i64
  %132 = getelementptr inbounds double, ptr %0, i64 %131
  store double %130, ptr %132, align 8
  %133 = add nsw i32 %.1431, 1
  %134 = sext i32 %133 to i64
  %135 = getelementptr inbounds double, ptr %0, i64 %134
  %136 = load double, ptr %135, align 8
  %137 = fsub double %136, %126
  %138 = add nsw i32 %107, 1
  %139 = sext i32 %138 to i64
  %140 = getelementptr inbounds double, ptr %0, i64 %139
  store double %137, ptr %140, align 8
  %141 = sext i32 %.1431 to i64
  %142 = getelementptr inbounds double, ptr %0, i64 %141
  %143 = load double, ptr %142, align 8
  %144 = fadd double %143, %117
  store double %144, ptr %142, align 8
  %145 = add nsw i32 %.1431, 1
  %146 = sext i32 %145 to i64
  %147 = getelementptr inbounds double, ptr %0, i64 %146
  %148 = load double, ptr %147, align 8
  %149 = fadd double %148, %126
  store double %149, ptr %147, align 8
  br label %150

150:                                              ; preds = %106
  %151 = add nsw i32 %.1431, %88
  %152 = icmp sle i32 %151, %24
  br i1 %152, label %106, label %._crit_edge34, !llvm.loop !18

._crit_edge34:                                    ; preds = %150
  br label %153

153:                                              ; preds = %._crit_edge34, %104
  br label %154

154:                                              ; preds = %153
  %155 = add nsw i32 %.135, 2
  %156 = icmp sle i32 %155, %102
  br i1 %156, label %104, label %._crit_edge38, !llvm.loop !19

._crit_edge38:                                    ; preds = %154
  br label %157

157:                                              ; preds = %._crit_edge38, %100
  %158 = fmul double %.0140, %98
  %159 = fneg double %158
  %160 = call double @llvm.fmuladd.f64(double %.041, double %97, double %159)
  %161 = fadd double %160, %.041
  %162 = fmul double %.041, %98
  %163 = call double @llvm.fmuladd.f64(double %.0140, double %97, double %162)
  %164 = fadd double %163, %.0140
  br label %165

165:                                              ; preds = %157
  %166 = add nsw i32 %.1639, %22
  %167 = icmp sle i32 %166, %.01445
  br i1 %167, label %100, label %._crit_edge44, !llvm.loop !20

._crit_edge44:                                    ; preds = %165
  br label %168

168:                                              ; preds = %._crit_edge44, %87
  %169 = icmp slt i32 %88, %23
  br i1 %169, label %87, label %._crit_edge48, !llvm.loop !21

._crit_edge48:                                    ; preds = %168
  br label %170

170:                                              ; preds = %._crit_edge48, %85
  %171 = mul nsw i32 %.01050, %19
  br label %172

172:                                              ; preds = %170
  %173 = add nsw i32 %.11249, -1
  %174 = icmp sge i32 %173, 1
  br i1 %174, label %16, label %._crit_edge53, !llvm.loop !22

._crit_edge53:                                    ; preds = %172
  br label %175

175:                                              ; preds = %._crit_edge53, %14
  ret void
}

; Function Attrs: nounwind
declare double @sin(double noundef) #5

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #6

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nocallback nofree nounwind willreturn writeonly }
attributes #5 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #7 = { nounwind allocsize(0) }
attributes #8 = { noreturn nounwind }
attributes #9 = { nounwind }

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
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
