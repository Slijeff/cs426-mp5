; ModuleID = './mp5_testcases_ll/nsieve-bits.ll'
source_filename = "./mp5_testcases/nsieve-bits.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [22 x i8] c"Primes up to %8d %8d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = udiv i32 40960000, 8
  %4 = zext i32 %3 to i64
  %5 = add i64 %4, 4
  %6 = call noalias ptr @malloc(i64 noundef %5) #5
  %7 = icmp ne ptr %6, null
  br i1 %7, label %9, label %8

8:                                                ; preds = %2
  br label %67

9:                                                ; preds = %2
  br label %10

10:                                               ; preds = %9, %63
  %.0311 = phi i32 [ 0, %9 ], [ %64, %63 ]
  %11 = lshr i32 40960000, %.0311
  %12 = udiv i32 %11, 8
  %13 = zext i32 %12 to i64
  %14 = add i64 %13, 4
  call void @llvm.memset.p0.i64(ptr align 4 %6, i8 -1, i64 %14, i1 false)
  %15 = icmp ule i32 2, %11
  br i1 %15, label %.lr.ph9, label %61

.lr.ph9:                                          ; preds = %10
  br label %16

16:                                               ; preds = %.lr.ph9, %58
  %.017 = phi i32 [ 0, %.lr.ph9 ], [ %.1, %58 ]
  %.046 = phi i32 [ 2, %.lr.ph9 ], [ %59, %58 ]
  %17 = zext i32 %.046 to i64
  %18 = udiv i64 %17, 32
  %19 = getelementptr inbounds i32, ptr %6, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = zext i32 %.046 to i64
  %22 = urem i64 %21, 32
  %23 = trunc i64 %22 to i32
  %24 = shl i32 1, %23
  %25 = and i32 %20, %24
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %57

27:                                               ; preds = %16
  %28 = add i32 %.017, 1
  %29 = add i32 %.046, %.046
  %30 = icmp ule i32 %29, %11
  br i1 %30, label %.lr.ph, label %56

.lr.ph:                                           ; preds = %27
  br label %31

31:                                               ; preds = %.lr.ph, %53
  %.025 = phi i32 [ %29, %.lr.ph ], [ %54, %53 ]
  %32 = zext i32 %.025 to i64
  %33 = udiv i64 %32, 32
  %34 = getelementptr inbounds i32, ptr %6, i64 %33
  %35 = load i32, ptr %34, align 4
  %36 = zext i32 %.025 to i64
  %37 = urem i64 %36, 32
  %38 = trunc i64 %37 to i32
  %39 = shl i32 1, %38
  %40 = and i32 %35, %39
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %42, label %52

42:                                               ; preds = %31
  %43 = zext i32 %.025 to i64
  %44 = urem i64 %43, 32
  %45 = trunc i64 %44 to i32
  %46 = shl i32 1, %45
  %47 = zext i32 %.025 to i64
  %48 = udiv i64 %47, 32
  %49 = getelementptr inbounds i32, ptr %6, i64 %48
  %50 = load i32, ptr %49, align 4
  %51 = xor i32 %50, %46
  store i32 %51, ptr %49, align 4
  br label %52

52:                                               ; preds = %42, %31
  br label %53

53:                                               ; preds = %52
  %54 = add i32 %.025, %.046
  %55 = icmp ule i32 %54, %11
  br i1 %55, label %31, label %._crit_edge, !llvm.loop !6

._crit_edge:                                      ; preds = %53
  br label %56

56:                                               ; preds = %._crit_edge, %27
  br label %57

57:                                               ; preds = %56, %16
  %.1 = phi i32 [ %28, %56 ], [ %.017, %16 ]
  br label %58

58:                                               ; preds = %57
  %59 = add i32 %.046, 1
  %60 = icmp ule i32 %59, %11
  br i1 %60, label %16, label %._crit_edge10, !llvm.loop !8

._crit_edge10:                                    ; preds = %58
  %split = phi i32 [ %.1, %58 ]
  br label %61

61:                                               ; preds = %._crit_edge10, %10
  %.01.lcssa = phi i32 [ %split, %._crit_edge10 ], [ 0, %10 ]
  %62 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %11, i32 noundef %.01.lcssa)
  br label %63

63:                                               ; preds = %61
  %64 = add i32 %.0311, 1
  %65 = icmp ule i32 %64, 2
  br i1 %65, label %10, label %66, !llvm.loop !9

66:                                               ; preds = %63
  call void @free(ptr noundef %6) #6
  br label %67

67:                                               ; preds = %66, %8
  %.0 = phi i32 [ 0, %66 ], [ 1, %8 ]
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
