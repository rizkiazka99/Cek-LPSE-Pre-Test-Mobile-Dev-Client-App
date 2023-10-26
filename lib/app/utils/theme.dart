import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0
      ),
      fontFamily: 'Poppins',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        displayMedium: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        displaySmall: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 18.sp,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
        bodySmall: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
        )
      ),
      colorScheme: const ColorScheme.light(primary: AppColors.primaryColor)
    );
  }
}