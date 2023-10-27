import 'dart:io';

import 'package:ceklpse_pretest_mobiledev/app/utils/constants.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget profilePicture({
  required String imageUrl,
  required double borderRadius 
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Image.network(
      imageUrl != 'https://cdn-icons-png.flaticon.com/512/5556/5556468.png'
          && imageUrl != 'https://cdn-icons-png.flaticon.com/512/7127/7127281.png'
              ? baseUrlImg + imageUrl
              : imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        return imageLoader(
          child: child,
          loadingProgress: loadingProgress,
          height: 150.h
        );
      }
    )
  );
}

Widget localProfilePicture({
  required File image,
  required double borderRadius 
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Image.file(
      image,
      fit: BoxFit.cover
    )
  );
}