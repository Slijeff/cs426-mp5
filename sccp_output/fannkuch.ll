; ModuleID = './mp5_testcases_ll/fannkuch.ll'
source_filename = "./mp5_testcases/fannkuch.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [23 x i8] c"Pfannkuchen(%d) = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = call i64 @fannkuch(i32 noundef 11)
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef 11, i64 noundef %3)
  ret i64 0
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind uwtable
define internal i64 @fannkuch(i32 noundef %0) #0 {
  %2 = sub nsw i32 %0, i64 1
  %3 = icmp slt i32 %0, i64 1
  br i1 %3, label %4, label %5

4:                                                ; preds = %1
  br label %127

5:                                                ; preds = %1
  %6 = sext i32 %0 to i64
  %7 = call noalias ptr @calloc(i64 noundef %6, i64 noundef 4) #3
  %8 = sext i32 %0 to i64
  %9 = call noalias ptr @calloc(i64 noundef %8, i64 noundef 4) #3
  %10 = sext i32 %0 to i64
  %11 = call noalias ptr @calloc(i64 noundef %10, i64 noundef 4) #3
  %12 = icmp slt i64 0, i32 %0
  br i1 %12, label %.lr.ph, label %19

.lr.ph:                                           ; preds = %5
  br label %13

13:                                               ; preds = %16, %.lr.ph
  %.0414 = phi i32 [ 0, %.lr.ph ], [ %17, %16 ]
  %14 = sext i32 %.0414 to i64
  %15 = getelementptr inbounds i32, ptr %9, i64 %14
  store i32 %.0414, ptr %15, align 4
  br label %16

16:                                               ; preds = %13
  %17 = add nsw i32 %.0414, i64 1
  %18 = icmp slt i32 %17, %0
  br i1 %18, label %13, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %16
  br label %19

19:                                               ; preds = %._crit_edge, %5
  br label %20

20:                                               ; preds = %126, %19
  %.010 = phi i32 [ %0, %19 ], [ %.212.lcssa13, %126 ]
  %.07 = phi i64 [ 0, %19 ], [ %.29, %126 ]
  %.02 = phi i32 [ 0, %19 ], [ %.1, %126 ]
  %21 = icmp slt i32 %.02, 30
  br i1 %21, label %22, label %36

22:                                               ; preds = %20
  %23 = icmp slt i64 0, i32 %0
  br i1 %23, label %.lr.ph17, label %33

.lr.ph17:                                         ; preds = %22
  br label %24

24:                                               ; preds = %30, %.lr.ph17
  %.1515 = phi i32 [ 0, %.lr.ph17 ], [ %31, %30 ]
  %25 = sext i32 %.1515 to i64
  %26 = getelementptr inbounds i32, ptr %9, i64 %25
  %27 = load i32, ptr %26, align 4
  %28 = add nsw i64 1, i32 %27
  %29 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %28)
  br label %30

30:                                               ; preds = %24
  %31 = add nsw i32 %.1515, i64 1
  %32 = icmp slt i32 %31, %0
  br i1 %32, label %24, label %._crit_edge18, !llvm.loop !8

._crit_edge18:                                    ; preds = %30
  br label %33

33:                                               ; preds = %._crit_edge18, %22
  %34 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %35 = add nsw i32 %.02, i64 1
  br label %36

36:                                               ; preds = %33, %20
  %.1 = phi i32 [ %35, %33 ], [ %.02, %20 ]
  %37 = icmp ne i32 %.010, i64 1
  br i1 %37, label %.lr.ph21, label %45

.lr.ph21:                                         ; preds = %36
  br label %38

38:                                               ; preds = %42, %.lr.ph21
  %.11119 = phi i32 [ %.010, %.lr.ph21 ], [ %43, %42 ]
  %39 = sub nsw i32 %.11119, i64 1
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i32, ptr %11, i64 %40
  store i32 %.11119, ptr %41, align 4
  br label %42

42:                                               ; preds = %38
  %43 = add nsw i32 %.11119, -1
  %44 = icmp ne i32 %43, i64 1
  br i1 %44, label %38, label %._crit_edge22, !llvm.loop !9

._crit_edge22:                                    ; preds = %42
  %split = phi i32 [ %43, %42 ]
  br label %45

45:                                               ; preds = %._crit_edge22, %36
  %.111.lcssa = phi i32 [ %split, %._crit_edge22 ], [ %.010, %36 ]
  %46 = getelementptr inbounds i32, ptr %9, i64 0
  %47 = load i32, ptr %46, align 4
  %48 = icmp eq i32 %47, i64 0
  br i1 %48, label %99, label %49

49:                                               ; preds = %45
  %50 = sext i32 %2 to i64
  %51 = getelementptr inbounds i32, ptr %9, i64 %50
  %52 = load i32, ptr %51, align 4
  %53 = icmp eq i32 %52, %2
  br i1 %53, label %99, label %54

54:                                               ; preds = %49
  %55 = icmp slt i64 1, i32 %0
  br i1 %55, label %.lr.ph25, label %65

.lr.ph25:                                         ; preds = %54
  br label %56

56:                                               ; preds = %62, %.lr.ph25
  %.223 = phi i32 [ 1, %.lr.ph25 ], [ %63, %62 ]
  %57 = sext i32 %.223 to i64
  %58 = getelementptr inbounds i32, ptr %9, i64 %57
  %59 = load i32, ptr %58, align 4
  %60 = sext i32 %.223 to i64
  %61 = getelementptr inbounds i32, ptr %7, i64 %60
  store i32 %59, ptr %61, align 4
  br label %62

62:                                               ; preds = %56
  %63 = add nsw i32 %.223, i64 1
  %64 = icmp slt i32 %63, %0
  br i1 %64, label %56, label %._crit_edge26, !llvm.loop !10

._crit_edge26:                                    ; preds = %62
  br label %65

65:                                               ; preds = %._crit_edge26, %54
  %66 = getelementptr inbounds i32, ptr %9, i64 0
  %67 = load i32, ptr %66, align 4
  br label %68

68:                                               ; preds = %93, %65
  %.06 = phi i64 [ 0, %65 ], [ %87, %93 ]
  %.03 = phi i32 [ %67, %65 ], [ %90, %93 ]
  %69 = sub nsw i32 %.03, i64 1
  %70 = icmp slt i64 1, i32 %69
  br i1 %70, label %.lr.ph30, label %86

.lr.ph30:                                         ; preds = %68
  br label %71

71:                                               ; preds = %82, %.lr.ph30
  %.0128 = phi i32 [ %69, %.lr.ph30 ], [ %84, %82 ]
  %.327 = phi i32 [ 1, %.lr.ph30 ], [ %83, %82 ]
  %72 = sext i32 %.327 to i64
  %73 = getelementptr inbounds i32, ptr %7, i64 %72
  %74 = load i32, ptr %73, align 4
  %75 = sext i32 %.0128 to i64
  %76 = getelementptr inbounds i32, ptr %7, i64 %75
  %77 = load i32, ptr %76, align 4
  %78 = sext i32 %.327 to i64
  %79 = getelementptr inbounds i32, ptr %7, i64 %78
  store i32 %77, ptr %79, align 4
  %80 = sext i32 %.0128 to i64
  %81 = getelementptr inbounds i32, ptr %7, i64 %80
  store i32 %74, ptr %81, align 4
  br label %82

82:                                               ; preds = %71
  %83 = add nsw i32 %.327, i64 1
  %84 = add nsw i32 %.0128, -1
  %85 = icmp slt i32 %83, %84
  br i1 %85, label %71, label %._crit_edge31, !llvm.loop !11

._crit_edge31:                                    ; preds = %82
  br label %86

86:                                               ; preds = %._crit_edge31, %68
  %87 = add nsw i64 %.06, 1
  %88 = sext i32 %.03 to i64
  %89 = getelementptr inbounds i32, ptr %7, i64 %88
  %90 = load i32, ptr %89, align 4
  %91 = sext i32 %.03 to i64
  %92 = getelementptr inbounds i32, ptr %7, i64 %91
  store i32 %.03, ptr %92, align 4
  br label %93

93:                                               ; preds = %86
  %94 = icmp ne i32 %90, i64 0
  br i1 %94, label %68, label %95, !llvm.loop !12

95:                                               ; preds = %93
  %.lcssa = phi i64 [ %87, %93 ]
  %96 = icmp slt i64 %.07, %.lcssa
  br i1 %96, label %97, label %98

97:                                               ; preds = %95
  br label %98

98:                                               ; preds = %97, %95
  %.18 = phi i64 [ %.lcssa, %97 ], [ %.07, %95 ]
  br label %99

99:                                               ; preds = %98, %49, %45
  %.29 = phi i64 [ %.07, %45 ], [ %.07, %49 ], [ %.18, %98 ]
  %100 = icmp eq i32 %.111.lcssa, %0
  br i1 %100, label %._crit_edge39, label %.lr.ph38

.lr.ph38:                                         ; preds = %99
  br label %102

._crit_edge39:                                    ; preds = %99
  %split40 = phi i64 [ %.29, %99 ]
  br label %101

._crit_edge41:                                    ; preds = %123
  %split42 = phi i64 [ %.29, %123 ]
  br label %101

101:                                              ; preds = %._crit_edge41, %._crit_edge39
  %.29.lcssa = phi i64 [ %split42, %._crit_edge41 ], [ %split40, %._crit_edge39 ]
  br label %127

102:                                              ; preds = %123, %.lr.ph38
  %.21236 = phi i32 [ %.111.lcssa, %.lr.ph38 ], [ %124, %123 ]
  %103 = getelementptr inbounds i32, ptr %9, i64 0
  %104 = load i32, ptr %103, align 4
  %105 = icmp slt i64 0, i32 %.21236
  br i1 %105, label %.lr.ph34, label %114

.lr.ph34:                                         ; preds = %102
  br label %106

106:                                              ; preds = %106, %.lr.ph34
  %.432 = phi i32 [ 0, %.lr.ph34 ], [ %107, %106 ]
  %107 = add nsw i32 %.432, i64 1
  %108 = sext i32 %107 to i64
  %109 = getelementptr inbounds i32, ptr %9, i64 %108
  %110 = load i32, ptr %109, align 4
  %111 = sext i32 %.432 to i64
  %112 = getelementptr inbounds i32, ptr %9, i64 %111
  store i32 %110, ptr %112, align 4
  %113 = icmp slt i32 %107, %.21236
  br i1 %113, label %106, label %._crit_edge35, !llvm.loop !13

._crit_edge35:                                    ; preds = %106
  br label %114

114:                                              ; preds = %._crit_edge35, %102
  %115 = sext i32 %.21236 to i64
  %116 = getelementptr inbounds i32, ptr %9, i64 %115
  store i32 %104, ptr %116, align 4
  %117 = sext i32 %.21236 to i64
  %118 = getelementptr inbounds i32, ptr %11, i64 %117
  %119 = load i32, ptr %118, align 4
  %120 = sub nsw i32 %119, i64 1
  store i32 %120, ptr %118, align 4
  %121 = icmp sgt i32 %120, i64 0
  br i1 %121, label %122, label %123

122:                                              ; preds = %114
  %.212.lcssa13 = phi i32 [ %.21236, %114 ]
  br label %126

123:                                              ; preds = %114
  %124 = add nsw i32 %.21236, i64 1
  %125 = icmp eq i32 %124, %0
  br i1 %125, label %._crit_edge41, label %102

126:                                              ; preds = %122
  br label %20

127:                                              ; preds = %101, %4
  %.0 = phi i64 [ 0, %4 ], [ %.29.lcssa, %101 ]
  ret i64 %.0
}

; Function Attrs: nounwind allocsize(0,1)
declare noalias ptr @calloc(i64 noundef, i64 noundef) #2

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind allocsize(0,1) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind allocsize(0,1) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i64 1, !"wchar_size", i32 4}
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
