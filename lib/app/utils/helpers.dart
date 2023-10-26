import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/constants.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

snackbar({
  required String title,
  required String message
}) {
  Get.snackbar(
    title, 
    message,
    backgroundColor: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(20),
    borderRadius: 20,
    boxShadows: boxShadows
  );
}

loaderDialog({
  required Widget loaderIcon, 
  required String message
}) {
  return Get.dialog(
    AlertDialog(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      content: Row(
        children: [
          SizedBox(
            width: 75.w,
            height: 50.h,
            child: loaderIcon,
          ),
          const Padding(
            padding: EdgeInsets.all(5),
          ),
          Expanded(
            child: Text(
              message,
              overflow: TextOverflow.fade,
              maxLines: 3,
            ),
          )
        ],
      )
    ),
    barrierDismissible: true
  );
}

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function() onConfirmation;
  final void Function() onCancellation;

  const ConfirmationDialog({
    super.key, 
    required this.title, 
    required this.content, 
    required this.onConfirmation, 
    required this.onCancellation
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Yes',
                onPressed: onConfirmation
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomButton(
                text: 'No', 
                color: AppColors.secondaryColor,
                onPressed: onCancellation
              ),
            ),
          ],
        )
      ],
    );
  }
}

imageLoader({
  required Widget child,
  required ImageChunkEvent? loadingProgress,
  double? width,
  double? height
}) {
  if (loadingProgress == null) {
    return child;
  } else {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: const SpinKitRing(
        color: AppColors.primaryColor,
        size: 80,
      ),
    );
  }
}

class UploadDialog extends StatelessWidget {
  final String title;
  final int received;
  final int total;

  const UploadDialog({
    super.key, 
    required this.title, 
    required this.received, 
    required this.total
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24)
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      content: LinearPercentIndicator(
        addAutomaticKeepAlive: true,
        progressColor: AppColors.primaryColor,
        percent: (received / total).toDouble()
      )
    );
  }
}