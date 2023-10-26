import 'package:animate_do/animate_do.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/constants.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/regex.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/background_decoration.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_button.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_card.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_dropdown.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  Widget authOptionsBar(BuildContext context) {
    Widget option({
      required void Function()? onTap,
      required String text,
      required int value,
    }) {
      return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: controller.selectedAuthOption != value ? Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.w600)
            )
          ) : CustomCard(
            emitShadow: false,
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 8.h
            ),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    )
              )
            )
          )
        )
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 8.h
      ),
      decoration: BoxDecoration(
        color: AppColors.contextGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Obx(() => Row(
        children: [          
          option(
            onTap: () => controller.selectedAuthOption = 0, 
            text: 'Login',
            value: 0
          ),
          option(
            onTap: () {
              controller.selectedAuthOption = 1;
              SchedulerBinding.instance.addPostFrameCallback((_) { 
                controller.scrollController.animateTo(
                  controller.scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.fastOutSlowIn
                );
              });
            }, 
            text: 'Register',
            value: 1
          )
        ],
      )),
    );
  }

  Widget login() {
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
                  formKey: controller.usernameLoginFormKey, 
                  autovalidateMode: controller.autoValidateUsernameLogin, 
                  controller: controller.usernameLoginController, 
                  hintText: 'Username', 
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username field cannot be left empty';
                    }
                  }
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h
                ),
                child: Obx(() => CustomForm(
                  formKey: controller.passwordLoginFormKey, 
                  autovalidateMode: controller.autoValidatePasswordLogin, 
                  controller: controller.passwordLoginController, 
                  hintText: 'Password',
                  obscureText: controller.isLoginPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.isLoginPasswordVisible = !controller.isLoginPasswordVisible;
                    },
                    child: Icon(
                      controller.isLoginPasswordVisible 
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password field cannot be left empty';
                    }
                  }
                ))
              )
            ]
          )
        )          
      ]
    );
  }

  Widget register(BuildContext context) {
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
                  formKey: controller.usernameRegisterFormKey, 
                  autovalidateMode: controller.autoValidateUsernameRegister, 
                  controller: controller.usernameRegisterController, 
                  hintText: 'Username',
                  maxLength: 16,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username field cannot be left empty';
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
                child: Obx(() => CustomForm(
                  formKey: controller.passwordRegisterFormKey, 
                  autovalidateMode: controller.autoValidatePasswordRegister, 
                  controller: controller.passwordRegisterController, 
                  hintText: 'Password',
                  obscureText: controller.isRegisterPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.isRegisterPasswordVisible = !controller.isRegisterPasswordVisible;
                    },
                    child: Icon(
                      controller.isRegisterPasswordVisible 
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
                ))
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
                child: Obx(() => CustomForm(
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
                      if (value != controller.passwordRegisterController.text) {
                        return 'Password was not confirmed';
                      }
                    }
                  }
                ))
              ),
              Obx(() => CustomDropdown(
                value: controller.selectedGender,
                hint: 'Gender',
                margin: EdgeInsets.only(top: 8.h),
                dropdownButtonPadding: EdgeInsets.only(
                  left: 8.w,
                  right: 17.w
                ),
                onChanged: (value) {
                  controller.selectedGender = value ?? '';
                },
                items: controller.genders.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(
                      gender,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),                  
                  );
                }).toList(),
                borderColor: Colors.transparent,
              ))
            ]
          )
        )          
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller.scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            backgroundDecoration(),
            FadeInUp(
              duration: const Duration(milliseconds: 1800),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 16.w)
                    .copyWith(bottom: 16.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h
                ),
                child: Column(
                  children: [
                    authOptionsBar(context),
                    SizedBox(height: 16.h),
                    Obx(() => controller.selectedAuthOption == 0
                        ? login()
                        : register(context)
                    ),
                    SizedBox(height: 16.h),
                    Obx(() => CustomButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        controller.selectedAuthOption == 0
                            ? controller.login()
                            : controller.register();
                      },
                      text: controller.selectedAuthOption == 0
                          ? 'Login'
                          : 'Register'
                    ))
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
