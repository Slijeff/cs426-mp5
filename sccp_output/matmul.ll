; ModuleID = './mp5_testcases_ll/matmul.ll'
source_filename = "./mp5_testcases/matmul.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @matmul(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5) #0 {
  %7 = zext i32 %0 to i64
  %8 = zext i32 %1 to i64
  %9 = zext i32 %1 to i64
  %10 = zext i32 %2 to i64
  %11 = zext i32 %0 to i64
  %12 = zext i32 %2 to i64
  %13 = icmp slt i32 0, %0
  br i1 %13, label %.lr.ph10, label %55

.lr.ph10:                                         ; preds = %6
  br label %14

14:                                               ; preds = %52, %.lr.ph10
  %.028 = phi i32 [ 0, %.lr.ph10 ], [ %53, %52 ]
  %15 = icmp slt i32 0, %2
  br i1 %15, label %.lr.ph6, label %51

.lr.ph6:                                          ; preds = %14
  br label %16

16:                                               ; preds = %48, %.lr.ph6
  %.014 = phi i32 [ 0, %.lr.ph6 ], [ %49, %48 ]
  %17 = sext i32 %.028 to i64
  %18 = mul nsw i64 %17, %12
  %19 = getelementptr inbounds i32, ptr %5, i64 %18
  %20 = sext i32 %.014 to i64
  %21 = getelementptr inbounds i32, ptr %19, i64 %20
  store i32 0, ptr %21, align 4
  %22 = icmp slt i32 0, %1
  br i1 %22, label %.lr.ph, label %47

.lr.ph:                                           ; preds = %16
  br label %23

23:                                               ; preds = %44, %.lr.ph
  %.03 = phi i32 [ 0, %.lr.ph ], [ %45, %44 ]
  %24 = sext i32 %.028 to i64
  %25 = mul nsw i64 %24, %8
  %26 = getelementptr inbounds i32, ptr %3, i64 %25
  %27 = sext i32 %.03 to i64
  %28 = getelementptr inbounds i32, ptr %26, i64 %27
  %29 = load i32, ptr %28, align 4
  %30 = sext i32 %.03 to i64
  %31 = mul nsw i64 %30, %10
  %32 = getelementptr inbounds i32, ptr %4, i64 %31
  %33 = sext i32 %.014 to i64
  %34 = getelementptr inbounds i32, ptr %32, i64 %33
  %35 = load i32, ptr %34, align 4
  %36 = mul nsw i32 %29, %35
  %37 = sext i32 %.028 to i64
  %38 = mul nsw i64 %37, %12
  %39 = getelementptr inbounds i32, ptr %5, i64 %38
  %40 = sext i32 %.014 to i64
  %41 = getelementptr inbounds i32, ptr %39, i64 %40
  %42 = load i32, ptr %41, align 4
  %43 = add nsw i32 %42, %36
  store i32 %43, ptr %41, align 4
  br label %44

44:                                               ; preds = %23
  %45 = add nsw i32 %.03, 1
  %46 = icmp slt i32 %45, %1
  br i1 %46, label %23, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %44
  br label %47

47:                                               ; preds = %._crit_edge, %16
  br label %48

48:                                               ; preds = %47
  %49 = add nsw i32 %.014, 1
  %50 = icmp slt i32 %49, %2
  br i1 %50, label %16, label %._crit_edge7, !llvm.loop !8

._crit_edge7:                                     ; preds = %48
  br label %51

51:                                               ; preds = %._crit_edge7, %14
  br label %52

52:                                               ; preds = %51
  %53 = add nsw i32 %.028, 1
  %54 = icmp slt i32 %53, %0
  br i1 %54, label %14, label %._crit_edge11, !llvm.loop !9

._crit_edge11:                                    ; preds = %52
  br label %55

55:                                               ; preds = %._crit_edge11, %6
  ret void
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
