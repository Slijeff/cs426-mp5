; ModuleID = './mp5_testcases_ll/nsieve-bits.ll'
source_filename = "./mp5_testcases/nsieve-bits.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [22 x i8] c"Primes up to %8d %8d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = call noalias ptr @malloc(i64 noundef 5120004) #5
  %4 = icmp ne ptr %3, null
  br i1 %4, label %6, label %5

5:                                                ; preds = %2
  br label %64

6:                                                ; preds = %2
  br label %7

7:                                                ; preds = %60, %6
  %.0311 = phi i32 [ 0, %6 ], [ %61, %60 ]
  %8 = lshr i32 40960000, %.0311
  %9 = udiv i32 %8, 8
  %10 = zext i32 %9 to i64
  %11 = add i64 %10, 4
  call void @llvm.memset.p0.i64(ptr align 4 %3, i8 -1, i64 %11, i1 false)
  %12 = icmp ule i32 2, %8
  br i1 %12, label %.lr.ph9, label %58

.lr.ph9:                                          ; preds = %7
  br label %13

13:                                               ; preds = %55, %.lr.ph9
  %.017 = phi i32 [ 0, %.lr.ph9 ], [ %.1, %55 ]
  %.046 = phi i32 [ 2, %.lr.ph9 ], [ %56, %55 ]
  %14 = zext i32 %.046 to i64
  %15 = udiv i64 %14, 32
  %16 = getelementptr inbounds i32, ptr %3, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = zext i32 %.046 to i64
  %19 = urem i64 %18, 32
  %20 = trunc i64 %19 to i32
  %21 = shl i32 1, %20
  %22 = and i32 %17, %21
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %54

24:                                               ; preds = %13
  %25 = add i32 %.017, 1
  %26 = add i32 %.046, %.046
  %27 = icmp ule i32 %26, %8
  br i1 %27, label %.lr.ph, label %53

.lr.ph:                                           ; preds = %24
  br label %28

28:                                               ; preds = %50, %.lr.ph
  %.025 = phi i32 [ %26, %.lr.ph ], [ %51, %50 ]
  %29 = zext i32 %.025 to i64
  %30 = udiv i64 %29, 32
  %31 = getelementptr inbounds i32, ptr %3, i64 %30
  %32 = load i32, ptr %31, align 4
  %33 = zext i32 %.025 to i64
  %34 = urem i64 %33, 32
  %35 = trunc i64 %34 to i32
  %36 = shl i32 1, %35
  %37 = and i32 %32, %36
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %39, label %49

39:                                               ; preds = %28
  %40 = zext i32 %.025 to i64
  %41 = urem i64 %40, 32
  %42 = trunc i64 %41 to i32
  %43 = shl i32 1, %42
  %44 = zext i32 %.025 to i64
  %45 = udiv i64 %44, 32
  %46 = getelementptr inbounds i32, ptr %3, i64 %45
  %47 = load i32, ptr %46, align 4
  %48 = xor i32 %47, %43
  store i32 %48, ptr %46, align 4
  br label %49

49:                                               ; preds = %39, %28
  br label %50

50:                                               ; preds = %49
  %51 = add i32 %.025, %.046
  %52 = icmp ule i32 %51, %8
  br i1 %52, label %28, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %50
  br label %53

53:                                               ; preds = %._crit_edge, %24
  br label %54

54:                                               ; preds = %53, %13
  %.1 = phi i32 [ %25, %53 ], [ %.017, %13 ]
  br label %55

55:                                               ; preds = %54
  %56 = add i32 %.046, 1
  %57 = icmp ule i32 %56, %8
  br i1 %57, label %13, label %._crit_edge10, !llvm.loop !8

._crit_edge10:                                    ; preds = %55
  %split = phi i32 [ %.1, %55 ]
  br label %58

58:                                               ; preds = %._crit_edge10, %7
  %.01.lcssa = phi i32 [ %split, %._crit_edge10 ], [ 0, %7 ]
  %59 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %8, i32 noundef %.01.lcssa)
  br label %60

60:                                               ; preds = %58
  %61 = add i32 %.0311, 1
  %62 = icmp ule i32 %61, 2
  br i1 %62, label %7, label %63, !llvm.loop !9

63:                                               ; preds = %60
  call void @free(ptr noundef %3) #6
  br label %64

64:                                               ; preds = %63, %5
  %.0 = phi i32 [ 0, %63 ], [ 1, %5 ]
  ret i32 %.0
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: argmemonly nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

declare i32 @printf(ptr noundef, ...) #3

; Function Attrs: nounwind
declare void @free(ptr noundef) #4

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { argmemonly nocallback nofree nounwind willreturn writeonly }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind allocsize(0) }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i64 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 15.0.7"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
