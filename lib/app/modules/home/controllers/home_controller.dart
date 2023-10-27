import 'dart:async';

import 'package:ceklpse_pretest_mobiledev/app/data/repositories/auth/auth_repository_implementation.dart';
import 'package:ceklpse_pretest_mobiledev/app/data/repositories/home/home_repository_implementation.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/home/profile_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/auth/logout_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/home/delete_account_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/home/profile_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/routes/app_pages.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/constants.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/global.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/helpers.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:ceklpse_pretest_mobiledev/app/widgets/bottom_sheets_and_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class DraggableMenuModel {
  final int id;
  final IconData icon;
  final String name;
  final void Function()? onTap;

  DraggableMenuModel({
    required this.id, 
    required this.icon,
    required this.name, 
    required this.onTap
  });
}

class HomeController extends GetxController {
  TextEditingController verifyPasswordController = TextEditingController();
  final verifyPasswordFormKey = GlobalKey<FormState>();
  var autoValidateVerifyPassword = AutovalidateMode.disabled;

  RxBool _isLoading = false.obs;
  RxBool _isError = false.obs;
  Rxn<ProfileEntity> _profileData = Rxn<ProfileEntity>();
  RxInt confirmationCountdown = 10.obs;
  RxBool isVerifyPasswordVisible = true.obs;

  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  ProfileEntity? get profileData => _profileData.value;

  set isLoading(bool isLoading) =>
      this._isLoading.value = isLoading;
  set isError(bool isError) =>
      this._isError.value = isError;
  set profileData(ProfileEntity? profileData) =>
      this._profileData.value = profileData;

  String errorMessage = '';

  List<DraggableMenuModel> draggableMenuItems = [
    DraggableMenuModel(
      id: 1, 
      icon: Icons.movie,
      name: 'Movies',
      onTap: () => Get.toNamed(Routes.MOVIES)
    ),
    DraggableMenuModel(
      id: 2, 
      icon: Icons.search_rounded,
      name: 'Search',
      onTap: () => Get.toNamed(Routes.SEARCH)
    ),
    DraggableMenuModel(
      id: 3, 
      icon: Icons.favorite_outline_rounded,
      name: 'Favorites',
      onTap: () => Get.toNamed(Routes.FAVORITE)
    ),
    DraggableMenuModel(
      id: 4, 
      icon: Icons.history,
      name: 'Watch History',
      onTap: () => Get.toNamed(Routes.WATCHHISTORY)
    )
  ];

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    verifyPasswordController.dispose();
    super.onClose();
  }

  deleteAccountCountdown() {
    Timer timer;

    timer = Timer.periodic(
      const Duration(seconds: 1), 
      (timer) { 
        if (confirmationCountdown.value == 0) {
          timer.cancel();
        } else {
          confirmationCountdown.value--;
        }
      }
    );
  }

  Future<void> getProfile() async {
    late ProfileUseCase profile;
    late Result<ProfileEntity> result;
    
    isLoading = true;
    isError = false;
    profile = ProfileUseCase(homeRepository: HomeRepositoryImplementation());
    result = await profile.call('');
    if (result.status is Success) {
      profileData = result.data;
    } else {
      isError = true;
      errorMessage = result.message;
    }
    isLoading = false;
  }

  Future<void> deleteAccount(BuildContext context) async {
    late DeleteAccountUseCase deleteAccount;
    late Result<CommonEntity> result;
    DeleteAccountParams params = DeleteAccountParams(
      id: profileData!.data!.id
    );

    deleteAccountCountdown();
    Get.dialog(verifyPasswordDialog(
      context: context, 
      formKey: verifyPasswordFormKey, 
      autoValidateMode: autoValidateVerifyPassword, 
      textEditingController: verifyPasswordController,
      obscurePassword: isVerifyPasswordVisible,
      username: profileData!.data!.username,
      title: 'Delete Account',
      description: 'Are you sure you want to delete your account? This action is irreversible and if you are, please verify your password after the timer reaches zero.',
      image: deleteAccountIllustration,
      useTimer: true,
      timer: confirmationCountdown,
      onVerifyTap: () async {
        Get.back();

        loaderDialog(
          loaderIcon: const SpinKitRing(color: AppColors.primaryColor),
          message: 'Please wait...'
        );
        deleteAccount = DeleteAccountUseCase(homeRepository: HomeRepositoryImplementation());
        result = await deleteAccount.call(params);

        if (result.status is Success) {
          localStorage.erase();
          Get.offAllNamed(Routes.AUTH);
          snackbar(
            title: 'Yay!', 
            message: result.data.message
          );
        } else {
          Get.back();
          snackbar(
            title: 'Yay!', 
            message: result.message
          );
        }
      }
    ));
  }

  logout() {
    late LogoutUseCase logout;
    late Result result;

    Get.dialog(ConfirmationDialog(
      title: 'Hold up!', 
      content: 'Are you sure you want to sign out of your account?',
      onConfirmation: () async {
        Get.closeCurrentSnackbar();
        loaderDialog(
          loaderIcon: const SpinKitRing(color: AppColors.primaryColor), 
          message: 'Please wait...'
        );
        logout = LogoutUseCase(authRepository: AuthRepositoryImplementation());
        result = await logout.call('initiate logout');

        if (result.status is Success) {
          snackbar(
            title: 'Yay!', 
            message: result.message
          );
        } else {
          snackbar(
            title: 'Oops!', 
            message: result.message
          );
        }
      }, 
      onCancellation: () {
        Get.back();
      }
    ));
  }

  handlePopupMenuClick({
    required BuildContext context,
    required int item
  }) {
    switch(item) {
      case 0:
        Get.toNamed(
          Routes.UPDATEPROFILE,
          arguments: {
            "id": profileData!.data!.id,
            "email": profileData!.data!.email,
            "username": profileData!.data!.username,
            "profile_picture": profileData!.data!.profilePicture
          }
        );
        break;
      case 1:
        deleteAccount(context);
        break;
      default:
        debugPrint('This does nothing');
        break;
    }
  }
}
