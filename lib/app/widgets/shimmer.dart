import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';

class Shimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? horizontalMargin;
  final double? verticalMargin;
  final double? borderRadius;

  const Shimmer({
    Key? key, 
    this.height, 
    this.width,
    this.horizontalMargin, 
    this.verticalMargin,
    this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin ?? 12.w,
        vertical: verticalMargin ?? 12.h
      ),
      child: SkeletonAnimation(
        shimmerColor: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        shimmerDuration: 1000,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            boxShadow: const [
              BoxShadow(color: AppColors.backgroundColorPrimary)
            ],
          ),
        ),
      ),
    );
  }
}

class CircleShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? horizontalMargin;
  final double? verticalMargin;
  final double? borderRadius;

  const CircleShimmer({
    Key? key, 
    this.height, 
    this.width,
    this.horizontalMargin, 
    this.verticalMargin,
    this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin ?? 12.w,
        vertical: verticalMargin ?? 12.h
      ),
      child: SkeletonAnimation(
        shimmerColor: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        shimmerDuration: 1000,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(color: AppColors.backgroundColorPrimary)
            ],
          ),
        ),
      ),
    );
  }
}