import 'package:animate_do/animate_do.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/helpers.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/regex.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/background_decoration.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/bottom_sheets_and_dialogs.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_button.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_card.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_form.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/profile_picture.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/updateprofile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  const UpdateProfileView({Key? key}) : super(key: key);

  Widget userAvatar(BuildContext context) {
    return Container(
      width: 150.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle
      ),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Obx(() => Container(
            width: 150.w,
            height: 150.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: controller.profilePicture == 'https://cdn-icons-png.flaticon.com/512/5556/5556468.png'
                    || controller.profilePicture == 'https://cdn-icons-png.flaticon.com/512/7127/7127281.png'
                        ? AppColors.primaryColor
                        : Colors.transparent, 
                width: controller.profilePicture == 'https://cdn-icons-png.flaticon.com/512/5556/5556468.png'
                    || controller.profilePicture == 'https://cdn-icons-png.flaticon.com/512/7127/7127281.png'
                        ? 2
                        : 0
              ),
              shape: BoxShape.circle
            ),
            child: controller.picturePath.isEmpty
                ? profilePicture(
                    imageUrl: controller.profilePicture, 
                    borderRadius: 100
                  )
                : localProfilePicture(
                    image: controller.image!, 
                    borderRadius: 100
                  )
          )),
          GestureDetector(
            onTap: () => uploadImageOptions(
              context: context,
              onCameraTap: () async {
                Get.back(); 
                await controller.getImageByCamera(); 
              },
              onGalleryTap: () async {
                Get.back(); 
                await controller.getImageFromGallery(); 
              }
            ),
            child: CustomCard(
              borderRadius: 100,
              padding: EdgeInsets.symmetric(
                vertical: 8.h, 
                horizontal: 8.w
              ),
              child: const Icon(
                Icons.edit,
                color: AppColors.primaryColor,
              )
            ),
          )
        ],
      )
    );
  }

  Widget form(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 5.h
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.contextGrey.withOpacity(0.1)
                    )
                  )
                ),
                child: CustomForm(
                  formKey: controller.emailFormKey, 
                  autovalidateMode: controller.autoValidateEmail, 
                  controller: controller.emailController, 
                  hintText: 'E-mail Address',
                  validator: (value) {
                    bool validate = EmailValidator.validate(value!);

                    if (value.isEmpty) {
                      return 'E-mail Address field cannot be left empty';
                    } else {
                      if (!validate) {
                        return 'Invalid e-mail address';
                      }
                    }
                  }
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.contextGrey.withOpacity(0.1)
                    )
                  )
                ),
                child: CustomForm(
                  formKey: controller.usernameFormKey, 
                  autovalidateMode: controller.autoValidateUsername, 
                  controller: controller.usernameController, 
                  hintText: 'Username',
                  maxLength: 16,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username field cannot be left empty';
                    }
                  }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    Obx(() => Switch(
                      value: controller.showPasswordForm,
                      activeColor: AppColors.primaryColor,
                      onChanged: (bool value) {
                        if (!controller.isPasswordVerified) {
                          Get.dialog(verifyPasswordDialog(
                            context: context, 
                            formKey: controller.verifyPasswordFormKey, 
                            autoValidateMode: controller.autoValidateVerifyPassword,
                            textEditingController: controller.verifyPasswordController,
                            controller: controller, 
                            obscurePassword: controller.isVerifyPasswordVisible, 
                            onVerifyTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.verifyPassword();
                            }
                          ));
                        } else {
                          controller.showPasswordForm = value;
                        }
                      },
                    )),
                    SizedBox(width: 4.w),
                    Text(
                      'Renew Password?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              Obx(() => controller.showPasswordForm ? Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.contextGrey.withOpacity(0.1)
                    )
                  )
                ),
                child: CustomForm(
                  formKey: controller.passwordFormKey, 
                  autovalidateMode: controller.autoValidatePassword, 
                  controller: controller.passwordController, 
                  hintText: 'Password',
                  obscureText: controller.isPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.isPasswordVisible = !controller.isPasswordVisible;
                    },
                    child: Icon(
                      controller.isPasswordVisible 
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  validator: (value) {
                    bool validate = CustomRegEx.validatePassword(value!);

                    if (value.isEmpty) {
                      return 'Password field cannot be left empty';
                    } else {
                      if (!validate) {
                        return 'Password must consist of at least 8 characters (1 uppercase letter, 1 lowercase letter and 1 numeric character)';
                      }
                    }
                  }
                )
              ) : const SizedBox.shrink()),
              Obx(() => controller.showPasswordForm ? Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h
                ),
                child: CustomForm(
                  formKey: controller.confirmPasswordFormKey, 
                  autovalidateMode: controller.autoValidateConfirmPassword, 
                  controller: controller.confirmPasswordController, 
                  hintText: 'Confirm Password',
                  obscureText: controller.isConfirmPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.isConfirmPasswordVisible = !controller.isConfirmPasswordVisible;
                    },
                    child: Icon(
                      controller.isConfirmPasswordVisible 
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirm Password field cannot be left empty';
                    } else {
                      if (value != controller.passwordController.text) {
                        return 'Password was not confirmed';
                      }
                    }
                  }
                )
              ) : const SizedBox.shrink())
            ]
          )
        )          
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (controller.emailController.text != controller.initialEmail
            || controller.usernameController.text != controller.initialUsername
            || controller.profilePicture != controller.initialProfilePicture
        ) {
          Get.dialog(
            ConfirmationDialog(
              title: 'Hold up!', 
              content: 'Are you sure you want to cancel updating your profile?', 
              onConfirmation: () {
                Get.back();
                Get.back();
              }, 
              onCancellation: () => Get.back()
            )
          );
          return Future.value(false);
        } else {
          Get.back();
          return Future.value(false);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            children: [
              backgroundDecoration(),
              SafeArea(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 1800),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 16.w)
                        .copyWith(bottom: 16.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userAvatar(context),
                        SizedBox(height: 16.h),
                        Obx(() => controller.isSizeLimitExceeded 
                            ? Text(
                                'Image should be 2MB or lower in size',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.secondaryColor)
                              )
                            : const SizedBox.shrink()
                        ),
                        Obx(() => controller.isSizeLimitExceeded 
                            ? SizedBox(height: 16.h)
                            : const SizedBox.shrink()
                        ),
                        form(context),
                        SizedBox(height: 16.h),
                        Obx(() => CustomButton(
                          onPressed: () { 
                            if (!controller.isSizeLimitExceeded) {
                              controller.initiateUpdateProfile();
                            }
                          },
                          color: !controller.isSizeLimitExceeded
                              ? AppColors.primaryColor
                              : AppColors.contextGrey.withOpacity(0.1),
                          text: 'Update'
                        ))
                      ]
                    )
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}
