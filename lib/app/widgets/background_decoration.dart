import 'package:animate_do/animate_do.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget backgroundDecoration() {
    return Container(
      height: 400.h,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(authBackground), 
          fit: BoxFit.fill
        )
      ),
      child: Stack(
        children: [
          Positioned(
            left: 30.w,
            width: 80.w,
            height: 200.h,
            child: FadeInUp(
              duration: const Duration(seconds: 1),
              child: Image.asset(lightOn)
            ),
          ),
          Positioned(
            left: 140.w,
            width: 80.w,
            height: 150.h,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1200),
              child: Image.asset(lightOff)
            ),
          ),
          Positioned(
            right: 40.w,
            top: 40.h,
            width: 80.w,
            height: 150.h,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1300),
              child: Image.asset(authClock)
            ),
          )
        ],
      ),
    );
  }