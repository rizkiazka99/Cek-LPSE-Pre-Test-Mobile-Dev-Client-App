import 'package:ceklpse_pretest_mobiledev/app/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool emitShadow;
  final Widget child;

  const CustomCard({
    super.key, 
    this.width, 
    this.height, 
    this.margin, 
    this.padding, 
    this.backgroundColor, 
    this.borderRadius, 
    this.emitShadow = true,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        boxShadow: emitShadow ? boxShadows : []
      ),
      child: child,
    );
  }
}