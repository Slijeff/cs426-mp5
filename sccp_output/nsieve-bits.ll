; ModuleID = './mp5_testcases_ll/nsieve-bits.ll'
source_filename = "./mp5_testcases/nsieve-bits.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [22 x i8] c"Primes up to %8d %8d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = zext i32 5120000 to i64
  %4 = add i64 %3, 4
  %5 = call noalias ptr @malloc(i64 noundef %4) #5
  %6 = icmp ne ptr %5, null
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  br label %66

8:                                                ; preds = %2
  br label %9

9:                                                ; preds = %62, %8
  %.0311 = phi i32 [ 0, %8 ], [ %63, %62 ]
  %10 = lshr i32 40960000, %.0311
  %11 = udiv i32 %10, 8
  %12 = zext i32 %11 to i64
  %13 = add i64 %12, 4
  call void @llvm.memset.p0.i64(ptr align 4 %5, i8 -1, i64 %13, i1 false)
  %14 = icmp ule i32 2, %10
  br i1 %14, label %.lr.ph9, label %60

.lr.ph9:                                          ; preds = %9
  br label %15

15:                                               ; preds = %57, %.lr.ph9
  %.017 = phi i32 [ 0, %.lr.ph9 ], [ %.1, %57 ]
  %.046 = phi i32 [ 2, %.lr.ph9 ], [ %58, %57 ]
  %16 = zext i32 %.046 to i64
  %17 = udiv i64 %16, 32
  %18 = getelementptr inbounds i32, ptr %5, i64 %17
  %19 = load i32, ptr %18, align 4
  %20 = zext i32 %.046 to i64
  %21 = urem i64 %20, 32
  %22 = trunc i64 %21 to i32
  %23 = shl i32 1, %22
  %24 = and i32 %19, %23
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %56

26:                                               ; preds = %15
  %27 = add i32 %.017, 1
  %28 = add i32 %.046, %.046
  %29 = icmp ule i32 %28, %10
  br i1 %29, label %.lr.ph, label %55

.lr.ph:                                           ; preds = %26
  br label %30

30:                                               ; preds = %52, %.lr.ph
  %.025 = phi i32 [ %28, %.lr.ph ], [ %53, %52 ]
  %31 = zext i32 %.025 to i64
  %32 = udiv i64 %31, 32
  %33 = getelementptr inbounds i32, ptr %5, i64 %32
  %34 = load i32, ptr %33, align 4
  %35 = zext i32 %.025 to i64
  %36 = urem i64 %35, 32
  %37 = trunc i64 %36 to i32
  %38 = shl i32 1, %37
  %39 = and i32 %34, %38
  %40 = icmp ne i32 %39, 0
  br i1 %40, label %41, label %51

41:                                               ; preds = %30
  %42 = zext i32 %.025 to i64
  %43 = urem i64 %42, 32
  %44 = trunc i64 %43 to i32
  %45 = shl i32 1, %44
  %46 = zext i32 %.025 to i64
  %47 = udiv i64 %46, 32
  %48 = getelementptr inbounds i32, ptr %5, i64 %47
  %49 = load i32, ptr %48, align 4
  %50 = xor i32 %49, %45
  store i32 %50, ptr %48, align 4
  br label %51

51:                                               ; preds = %41, %30
  br label %52

52:                                               ; preds = %51
  %53 = add i32 %.025, %.046
  %54 = icmp ule i32 %53, %10
  br i1 %54, label %30, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %52
  br label %55

55:                                               ; preds = %._crit_edge, %26
  br label %56

56:                                               ; preds = %55, %15
  %.1 = phi i32 [ %27, %55 ], [ %.017, %15 ]
  br label %57

57:                                               ; preds = %56
  %58 = add i32 %.046, 1
  %59 = icmp ule i32 %58, %10
  br i1 %59, label %15, label %._crit_edge10, !llvm.loop !8

._crit_edge10:                                    ; preds = %57
  %split = phi i32 [ %.1, %57 ]
  br label %60

60:                                               ; preds = %._crit_edge10, %9
  %.01.lcssa = phi i32 [ %split, %._crit_edge10 ], [ 0, %9 ]
  %61 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %10, i32 noundef %.01.lcssa)
  br label %62

62:                                               ; preds = %60
  %63 = add i32 %.0311, 1
  %64 = icmp ule i32 %63, 2
  br i1 %64, label %9, label %65, !llvm.loop !9

65:                                               ; preds = %62
  call void @free(ptr noundef %5) #6
  br label %66

66:                                               ; preds = %65, %7
  %.0 = phi i32 [ 0, %65 ], [ 1, %7 ]
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
