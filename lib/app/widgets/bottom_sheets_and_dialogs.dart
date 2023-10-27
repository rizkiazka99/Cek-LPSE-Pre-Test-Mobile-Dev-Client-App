import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/common_functions.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/constants.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_button.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'custom_card.dart';

uploadImageOptions({
  required BuildContext context,
  required void Function()? onCameraTap,
  required void Function()? onGalleryTap
}) async {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30)
      )
    ),
    builder: (context) {
      return SizedBox(
        height: 130.h,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkResponse(
              containedInkWell: false,
              radius: 80,
              onTap: onCameraTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 24.h
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 48.sp,
                      color: AppColors.primaryColor,
                    ),
                    const Text('Camera')
                  ],
                ),
              ),
            ),
            InkResponse(
              containedInkWell: false,
              radius: 80,
              onTap: onGalleryTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 24.h
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.image,
                      size: 48.sp,
                      color: AppColors.primaryColor,
                    ),
                    const Text('Gallery')
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  );
}

Widget verifyPasswordDialog({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required AutovalidateMode autoValidateMode,
  required TextEditingController textEditingController,
  required RxBool obscurePassword,
  String? title,
  String? image,
  String? description,
  required String username,
  required Function onVerifyTap,
  bool useTimer = false,
  RxInt? timer
}) {
  Widget nonTimedVerifyButton() {
    return CustomButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        verifyPassword(
          verifyPasswordFormKey: formKey, 
          autoValidateVerifyPassword: autoValidateMode, 
          verifyPasswordController: textEditingController, 
          username: username, 
          successAction: () async {
            onVerifyTap();
          }
        );
      }, 
      text: 'Verify'
    );
  }

  Widget timedVerifyButton() {
    return Obx(() => CustomButton(
      onPressed: () {}, 
      text: 'Verify (${timer!.value})',
      color: AppColors.contextGrey.withOpacity(0.1),
    ));
  }
  

  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 10.w,
      vertical: 10.h
    ),
    child: Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h
          ),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? 'Password Verification',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Center(
              child: Image.asset(
                image ?? verifyPasswordIllustration,
                width: 300.w,
                height: 200.h
              ),
            ),
            SizedBox(height: 16.h),
              Text(
                description 
                    ?? 'Before you renew your password, please verify your current one first',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              CustomCard(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 5.h
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 8.h
                  ),
                  child: Obx(() {
                      return CustomForm(
                        formKey: formKey,
                        autovalidateMode: autoValidateMode,
                        controller: textEditingController,
                        hintText: 'Password',
                        obscureText: obscurePassword.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscurePassword.value = !obscurePassword.value;
                          },
                          icon: Icon(
                            obscurePassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.primaryColor)
                          ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password field cannot be empty';
                          }
                        }
                      );
                    },
                  )
                )
              ),
              SizedBox(height: 16.h),
              useTimer ? Obx(() => timer!.value != 0
                  ? timedVerifyButton()
                  : nonTimedVerifyButton()
              ) : nonTimedVerifyButton(),
              SizedBox(height: 8.h),
              CustomButton(
                onPressed: () => Get.back(), 
                color: AppColors.secondaryColor, 
                text: 'Cancel'
              ),
            ],
          ),
        ),
      ),
    ),
  );
}