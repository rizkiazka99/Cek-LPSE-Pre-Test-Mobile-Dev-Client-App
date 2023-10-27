import 'package:ceklpse_pretest_mobiledev/app/data/repositories/updateprofile/update_profile_repository_implementation.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/updateprofile/verify_password_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/helpers.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

Future<void> verifyPassword({
  required GlobalKey<FormState> verifyPasswordFormKey,
  required AutovalidateMode autoValidateVerifyPassword,
  required TextEditingController verifyPasswordController,
  required String username,
  required Function successAction
}) async {
    final isVerifyPasswordValid = verifyPasswordFormKey.currentState!.validate();

    if (isVerifyPasswordValid) {
      late VerifyPasswordUseCase verifyPassword;
      late Result<CommonEntity> result;
      VerifyPasswordParams params = VerifyPasswordParams(
        username: username,
        password: verifyPasswordController.text.trim()
      );

      loaderDialog(
        loaderIcon: const SpinKitRing(color: AppColors.primaryColor),
        message: 'Please wait...'
      );
      verifyPassword = VerifyPasswordUseCase(
        updateProfileRepository: UpdateProfileRepositoryImplementation()
      );
      result = await verifyPassword.call(params);
  
      if (result.status is Success) {
        successAction();
      } else {
        Get.back();
        snackbar(title: 'Oops!', message: result.message);
      }
    } else {
      autoValidateVerifyPassword = AutovalidateMode.always;
    }
  }