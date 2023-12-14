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
  store i32 256, ptr getelementptr inbounds ([3 x i32], ptr @main.nsize, i64 0, i64 2), align 4
  store i32 256, ptr getelementptr inbounds ([3 x i32], ptr @main.nsize, i64 0, i64 1), align 4
  %1 = call noalias ptr @malloc(i64 noundef 1048592) #7
  %2 = icmp eq ptr %1, null
  br i1 %2, label %3, label %6

3:                                                ; preds = %0
  %4 = load ptr, ptr @stderr, align 8
  %5 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef @.str)
  call void @exit(i64 noundef 1) #8
  unreachable

6:                                                ; preds = %0
  call void @llvm.memset.p0.i64(ptr align 8 %1, i8 0, i64 1048592, i64 0)
  br label %7

7:                                                ; preds = %26, %6
  %.0114 = phi i32 [ 0, %6 ], [ %27, %26 ]
  br label %8

8:                                                ; preds = %22, %7
  %.0212 = phi i32 [ 0, %7 ], [ %23, %22 ]
  %9 = and i32 %.0114, 15
  %10 = icmp eq i32 %9, 8
  br i1 %10, label %14, label %11

11:                                               ; preds = %8
  %12 = and i32 %.0212, 15
  %13 = icmp eq i32 %12, 8
  br i1 %13, label %14, label %21

14:                                               ; preds = %11, %8
  %15 = mul nsw i32 256, %.0114
  %16 = add nsw i32 %15, %.0212
  %17 = mul nsw i32 %16, i64 2
  %18 = add nsw i64 1, i32 %17
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds double, ptr %1, i64 %19
  store double 1.280000e+02, ptr %20, align 8
  br label %21

21:                                               ; preds = %14, %11
  %.0213 = phi i32 [ %.0212, %14 ], [ %.0212, %11 ]
  br label %22

22:                                               ; preds = %21
  %23 = add nsw i32 %.0213, i64 1
  %24 = icmp slt i32 %23, 256
  br i1 %24, label %8, label %25, !llvm.loop !6

25:                                               ; preds = %22
  br label %26

26:                                               ; preds = %25
  %27 = add nsw i32 %.0114, i64 1
  %28 = icmp slt i32 %27, 256
  br i1 %28, label %7, label %29, !llvm.loop !8

29:                                               ; preds = %26
  br label %30

30:                                               ; preds = %31, %29
  %.115 = phi i32 [ 0, %29 ], [ %32, %31 ]
  call void @fourn(ptr noundef %1, ptr noundef @main.nsize, i64 noundef 2, i64 noundef 1)
  call void @fourn(ptr noundef %1, ptr noundef @main.nsize, i64 noundef 2, i32 noundef -1)
  br label %31

31:                                               ; preds = %30
  %32 = add nsw i32 %.115, i64 1
  %33 = icmp slt i32 %32, 63
  br i1 %33, label %30, label %34, !llvm.loop !9

34:                                               ; preds = %31
  br label %.lr.ph

.lr.ph:                                           ; preds = %34, <null operand!>
  br label %35

35:                                               ; preds = %65, %.lr.ph
  %.022 = phi double [ 0.000000e+00, %.lr.ph ], [ %44, %65 ]
  %.221 = phi i32 [ 1, %.lr.ph ], [ %66, %65 ]
  %.0420 = phi double [ 0.000000e+00, %.lr.ph ], [ %43, %65 ]
  %.0519 = phi double [ -1.000000e+10, %.lr.ph ], [ %64, %65 ]
  %.0918 = phi double [ 1.000000e+10, %.lr.ph ], [ %59, %65 ]
  %.01017 = phi double [ -1.000000e+10, %.lr.ph ], [ %54, %65 ]
  %.01116 = phi double [ 1.000000e+10, %.lr.ph ], [ %49, %65 ]
  %36 = sext i32 %.221 to i64
  %37 = getelementptr inbounds double, ptr %1, i64 %36
  %38 = load double, ptr %37, align 8
  %39 = add nsw i32 %.221, i64 1
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds double, ptr %1, i64 %40
  %42 = load double, ptr %41, align 8
  %43 = fadd double %.0420, %38
  %44 = fadd double %.022, %42
  %45 = fcmp ole double %38, %.01116
  br i1 %45, label %46, label %47

46:                                               ; preds = %35
  br label %48

47:                                               ; preds = %35
  br label %48

48:                                               ; preds = %47, %46
  %49 = phi double [ %38, %46 ], [ %.01116, %47 ]
  %50 = fcmp ogt double %38, %.01017
  br i1 %50, label %51, label %52

51:                                               ; preds = %48
  br label %53

52:                                               ; preds = %48
  br label %53

53:                                               ; preds = %52, %51
  %54 = phi double [ %38, %51 ], [ %.01017, %52 ]
  %55 = fcmp ole double %42, %.0918
  br i1 %55, label %56, label %57

56:                                               ; preds = %53
  br label %58

57:                                               ; preds = %53
  br label %58

58:                                               ; preds = %57, %56
  %59 = phi double [ %42, %56 ], [ %.0918, %57 ]
  %60 = fcmp ogt double %42, %.0519
  br i1 %60, label %61, label %62

61:                                               ; preds = %58
  br label %63

62:                                               ; preds = %58
  br label %63

63:                                               ; preds = %62, %61
  %64 = phi double [ %42, %61 ], [ %.0519, %62 ]
  br label %65

65:                                               ; preds = %63
  %66 = add nsw i32 %.221, i64 2
  %67 = sext i32 %66 to i64
  %68 = icmp sle i64 %67, 65536
  br i1 %68, label %35, label %._crit_edge, !llvm.loop !10

._crit_edge:                                      ; preds = %65
  %split = phi double [ %49, %65 ]
  %split23 = phi double [ %54, %65 ]
  br label %69

69:                                               ; preds = %._crit_edge, <null operand!>
  %.011.lcssa = phi double [ %split, %._crit_edge ], [ 1.000000e+10, %34 ]
  %.010.lcssa = phi double [ %split23, %._crit_edge ], [ -1.000000e+10, %34 ]
  %70 = fsub double %.010.lcssa, %.011.lcssa
  %71 = fdiv double 2.550000e+02, %70
  br label %72

72:                                               ; preds = %103, %69
  %.327 = phi i32 [ 0, %69 ], [ %104, %103 ]
  %.0626 = phi i32 [ 0, %69 ], [ %.17.lcssa, %103 ]
  br label %73

73:                                               ; preds = %99, %72
  %.1325 = phi i32 [ 0, %72 ], [ %100, %99 ]
  %.1724 = phi i32 [ %.0626, %72 ], [ %.28, %99 ]
  %74 = mul nsw i32 256, %.327
  %75 = add nsw i32 %74, %.1325
  %76 = mul nsw i32 %75, i64 2
  %77 = add nsw i64 1, i32 %76
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds double, ptr %1, i64 %78
  %80 = load double, ptr %79, align 8
  %81 = fsub double %80, %.011.lcssa
  %82 = fmul double %81, %71
  %83 = fptosi double %82 to i32
  %84 = and i32 %.327, 15
  %85 = icmp eq i32 %84, 8
  br i1 %85, label %89, label %86

86:                                               ; preds = %73
  %87 = and i32 %.1325, 15
  %88 = icmp eq i32 %87, 8
  br label %89

89:                                               ; preds = %86, %73
  %90 = phi i1 [ true, %73 ], [ %88, %86 ]
  %91 = zext i1 %90 to i64
  %92 = select i1 %90, i32 255, i32 0
  %93 = icmp ne i32 %83, %92
  br i1 %93, label %94, label %98

94:                                               ; preds = %89
  %95 = add nsw i32 %.1724, i64 1
  %96 = load ptr, ptr @stderr, align 8
  %97 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %96, ptr noundef @.str.1, i32 noundef %.327, i32 noundef %.1325, i32 noundef %92, i32 noundef %83)
  br label %98

98:                                               ; preds = %94, %89
  %.28 = phi i32 [ %95, %94 ], [ %.1724, %89 ]
  br label %99

99:                                               ; preds = %98
  %100 = add nsw i32 %.1325, i64 1
  %101 = icmp slt i32 %100, 256
  br i1 %101, label %73, label %102, !llvm.loop !11

102:                                              ; preds = %99
  %.17.lcssa = phi i32 [ %.28, %99 ]
  br label %103

103:                                              ; preds = %102
  %104 = add nsw i32 %.327, i64 1
  %105 = icmp slt i32 %104, 256
  br i1 %105, label %72, label %106, !llvm.loop !12

106:                                              ; preds = %103
  %.06.lcssa = phi i32 [ %.17.lcssa, %103 ]
  %107 = icmp eq i32 %.06.lcssa, 0
  br i1 %107, label %108, label %111

108:                                              ; preds = %106
  %109 = load ptr, ptr @stderr, align 8
  %110 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %109, ptr noundef @.str.2, i32 noundef 63)
  br label %114

111:                                              ; preds = %106
  %112 = load ptr, ptr @stderr, align 8
  %113 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %112, ptr noundef @.str.3, i32 noundef 63, i32 noundef %.06.lcssa)
  br label %114

114:                                              ; preds = %111, %108
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
  %5 = icmp sle i64 1, i32 %2
  br i1 %5, label %.lr.ph, label %14

.lr.ph:                                           ; preds = %4
  br label %6

6:                                                ; preds = %11, %.lr.ph
  %.0916 = phi i32 [ 1, %.lr.ph ], [ %10, %11 ]
  %.01115 = phi i32 [ 1, %.lr.ph ], [ %12, %11 ]
  %7 = sext i32 %.01115 to i64
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4
  %10 = mul nsw i32 %.0916, %9
  br label %11

11:                                               ; preds = %6
  %12 = add nsw i32 %.01115, i64 1
  %13 = icmp sle i32 %12, %2
  br i1 %13, label %6, label %._crit_edge, !llvm.loop !13

._crit_edge:                                      ; preds = %11
  %split = phi i32 [ %10, %11 ]
  br label %14

14:                                               ; preds = %._crit_edge, %4
  %.09.lcssa = phi i32 [ %split, %._crit_edge ], [ 1, %4 ]
  %15 = icmp sge i32 %2, i64 1
  br i1 %15, label %.lr.ph52, label %175

.lr.ph52:                                         ; preds = %14
  br label %16

16:                                               ; preds = %172, %.lr.ph52
  %.01050 = phi i32 [ 1, %.lr.ph52 ], [ %171, %172 ]
  %.11249 = phi i32 [ %2, %.lr.ph52 ], [ %173, %172 ]
  %17 = sext i32 %.11249 to i64
  %18 = getelementptr inbounds i32, ptr %1, i64 %17
  %19 = load i32, ptr %18, align 4
  %20 = mul nsw i32 %19, %.01050
  %21 = sdiv i32 %.09.lcssa, %20
  %22 = shl i32 %.01050, i64 1
  %23 = mul nsw i32 %22, %19
  %24 = mul nsw i32 %23, %21
  %25 = icmp sle i64 1, i32 %23
  br i1 %25, label %.lr.ph29, label %85

.lr.ph29:                                         ; preds = %16
  br label %26

26:                                               ; preds = %82, %.lr.ph29
  %.0326 = phi i32 [ 1, %.lr.ph29 ], [ %83, %82 ]
  %.0725 = phi i32 [ 1, %.lr.ph29 ], [ %81, %82 ]
  %27 = icmp slt i32 %.0326, %.0725
  br i1 %27, label %28, label %69

28:                                               ; preds = %26
  %29 = add nsw i32 %.0326, %22
  %30 = sub nsw i32 %29, i64 2
  %31 = icmp sle i32 %.0326, %30
  br i1 %31, label %.lr.ph23, label %68

.lr.ph23:                                         ; preds = %28
  br label %32

32:                                               ; preds = %65, %.lr.ph23
  %.0221 = phi i32 [ %.0326, %.lr.ph23 ], [ %66, %65 ]
  %33 = icmp sle i32 %.0221, %24
  br i1 %33, label %.lr.ph19, label %64

.lr.ph19:                                         ; preds = %32
  br label %34

34:                                               ; preds = %61, %.lr.ph19
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
  %47 = add nsw i32 %.0517, i64 1
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds double, ptr %0, i64 %48
  %50 = load double, ptr %49, align 8
  %51 = add nsw i32 %36, i64 1
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds double, ptr %0, i64 %52
  %54 = load double, ptr %53, align 8
  %55 = add nsw i32 %.0517, i64 1
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds double, ptr %0, i64 %56
  store double %54, ptr %57, align 8
  %58 = add nsw i32 %36, i64 1
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
  %66 = add nsw i32 %.0221, i64 2
  %67 = icmp sle i32 %66, %30
  br i1 %67, label %32, label %._crit_edge24, !llvm.loop !15

._crit_edge24:                                    ; preds = %65
  br label %68

68:                                               ; preds = %._crit_edge24, %28
  br label %69

69:                                               ; preds = %68, %26
  %.0327 = phi i32 [ %.0326, %68 ], [ %.0326, %26 ]
  %70 = ashr i32 %23, i64 1
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
  %76 = phi i1 [ 0, %71 ], [ %74, %73 ]
  br i1 %76, label %77, label %80

77:                                               ; preds = %75
  %78 = sub nsw i32 %.18, %.013
  %79 = ashr i32 %.013, i64 1
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

87:                                               ; preds = %168, %.lr.ph47
  %.01445 = phi i32 [ %22, %.lr.ph47 ], [ %88, %168 ]
  %88 = shl i32 %.01445, i64 1
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
  %99 = icmp sle i64 1, i32 %.01445
  br i1 %99, label %.lr.ph43, label %168

.lr.ph43:                                         ; preds = %87
  br label %100

100:                                              ; preds = %165, %.lr.ph43
  %.041 = phi double [ 1.000000e+00, %.lr.ph43 ], [ %161, %165 ]
  %.0140 = phi double [ 0.000000e+00, %.lr.ph43 ], [ %164, %165 ]
  %.1639 = phi i32 [ 1, %.lr.ph43 ], [ %166, %165 ]
  %101 = add nsw i32 %.1639, %22
  %102 = sub nsw i32 %101, i64 2
  %103 = icmp sle i32 %.1639, %102
  br i1 %103, label %.lr.ph37, label %157

.lr.ph37:                                         ; preds = %100
  br label %104

104:                                              ; preds = %154, %.lr.ph37
  %.135 = phi i32 [ %.1639, %.lr.ph37 ], [ %155, %154 ]
  %105 = icmp sle i32 %.135, %24
  br i1 %105, label %.lr.ph33, label %153

.lr.ph33:                                         ; preds = %104
  br label %106

106:                                              ; preds = %150, %.lr.ph33
  %.1431 = phi i32 [ %.135, %.lr.ph33 ], [ %151, %150 ]
  %107 = add nsw i32 %.1431, %.01445
  %108 = sext i32 %107 to i64
  %109 = getelementptr inbounds double, ptr %0, i64 %108
  %110 = load double, ptr %109, align 8
  %111 = add nsw i32 %107, i64 1
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds double, ptr %0, i64 %112
  %114 = load double, ptr %113, align 8
  %115 = fmul double %.0140, %114
  %116 = fneg double %115
  %117 = call double @llvm.fmuladd.f64(double %.041, double %110, double %116)
  %118 = add nsw i32 %107, i64 1
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
  %133 = add nsw i32 %.1431, i64 1
  %134 = sext i32 %133 to i64
  %135 = getelementptr inbounds double, ptr %0, i64 %134
  %136 = load double, ptr %135, align 8
  %137 = fsub double %136, %126
  %138 = add nsw i32 %107, i64 1
  %139 = sext i32 %138 to i64
  %140 = getelementptr inbounds double, ptr %0, i64 %139
  store double %137, ptr %140, align 8
  %141 = sext i32 %.1431 to i64
  %142 = getelementptr inbounds double, ptr %0, i64 %141
  %143 = load double, ptr %142, align 8
  %144 = fadd double %143, %117
  store double %144, ptr %142, align 8
  %145 = add nsw i32 %.1431, i64 1
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
  %155 = add nsw i32 %.135, i64 2
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
  %174 = icmp sge i32 %173, i64 1
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

!0 = !{i64 1, !"wchar_size", i64 4}
!1 = !{i32 7, !"PIC Level", i64 2}
!2 = !{i32 7, !"PIE Level", i64 2}
!3 = !{i32 7, !"uwtable", i64 2}
!4 = !{i32 7, !"frame-pointer", i64 2}
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
