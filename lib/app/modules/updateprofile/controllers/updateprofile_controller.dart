import 'dart:io';
import 'package:ceklpse_pretest_mobiledev/app/data/repositories/updateprofile/update_profile_repository_implementation.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/updateprofile/update_profile_picture_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/updateprofile/update_profile_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/routes/app_pages.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/helpers.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final emailFormKey = GlobalKey<FormState>();
  final usernameFormKey = GlobalKey<FormState>();
  final verifyPasswordFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();

  var autoValidateEmail = AutovalidateMode.disabled;
  var autoValidateUsername = AutovalidateMode.disabled;
  var autoValidateVerifyPassword = AutovalidateMode.disabled;
  var autoValidatePassword = AutovalidateMode.disabled;
  var autoValidateConfirmPassword = AutovalidateMode.disabled;

  File? _image;
  File? get image => _image;
  set image(File? image) => this._image = image;

  RxString _picturePath = ''.obs;
  RxBool _isSizeLimitExceeded = false.obs;
  RxInt _uploadProgressReceived = 0.obs;
  RxInt _uploadProgressTotal = 1.obs;
  RxBool _isProfilePictureUploaded = false.obs;
  RxBool _isPasswordVerified = false.obs;
  RxBool _showPasswordForm = false.obs;
  RxBool isVerifyPasswordVisible = true.obs;
  RxBool _isPasswordVisible = true.obs;
  RxBool _isConfirmPasswordVisible = true.obs;

  String get picturePath => _picturePath.value;
  bool get isSizeLimitExceeded => _isSizeLimitExceeded.value;
  int get uploadProgressReceived => _uploadProgressReceived.value;
  int get uploadProgressTotal => _uploadProgressTotal.value;
  bool get isProfilePictureUploaded => _isProfilePictureUploaded.value;
  bool get isPasswordVerified => _isPasswordVerified.value;
  bool get showPasswordForm => _showPasswordForm.value;
  bool get isPasswordVisible => _isPasswordVisible.value;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;

  set picturePath(String picturePath) =>
      this._picturePath.value = picturePath;
  set isSizeLimitExceeded(bool isSizeLimitExceeded) =>
      this._isSizeLimitExceeded.value = isSizeLimitExceeded;
  set uploadProgressReceived(int uploadProgressReceived) =>
      this._uploadProgressReceived.value = uploadProgressReceived;
  set uploadProgressTotal(int uploadProgressTotal) =>
      this._uploadProgressTotal.value = uploadProgressTotal;
  set isProfilePictureUploaded(bool isProfilePictureUploaded) =>
      this._isProfilePictureUploaded.value = isProfilePictureUploaded;
  set isPasswordVerified(bool isPasswordVerified) =>
      this._isPasswordVerified.value = isPasswordVerified;
  set showPasswordForm(bool showPasswordForm) =>
      this._showPasswordForm.value = showPasswordForm;
  set isPasswordVisible(bool isPasswordVisible) =>
      this._isPasswordVisible.value = isPasswordVisible;
  set isConfirmPasswordVisible(bool isConfirmPasswordVisible) =>
      this._isConfirmPasswordVisible.value = isConfirmPasswordVisible;

  late String id;
  late String profilePicture;
  late String initialEmail;
  late String initialUsername;
  late String initialProfilePicture;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'];
    emailController.text = Get.arguments['email'];
    initialEmail = Get.arguments['email'];
    usernameController.text = Get.arguments['username'];
    initialUsername = Get.arguments['username'];
    profilePicture = Get.arguments['profile_picture'];
    initialProfilePicture = Get.arguments['profile_picture'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    usernameController.dispose();
    verifyPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future getImageByCamera() async {
    var picture = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50
    );

    var pictureProperties = await picture!.readAsBytes();
    int maxFileSizeInBytes = 2 * 1048576;
    int fileSize = pictureProperties.length;

    if (fileSize <= maxFileSizeInBytes) {
      if (picture.path.isNotEmpty) {
        isSizeLimitExceeded = false;
        picturePath = picture.path;
        profilePicture = picturePath;
        image = File(picture.path);
      }
    } else {
      if (picture.path.isNotEmpty) {
        isSizeLimitExceeded = true;
        picturePath = picture.path;
        profilePicture = picturePath;
        image = File(picture.path);
      }
    }
  }

  Future getImageFromGallery() async {
    var picture = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30
    );
    var pictureProperties = await picture!.readAsBytes();
    int maxFileSizeInBytes = 2 * 1048576;
    int fileSize = pictureProperties.length;
    debugPrint((fileSize).toString());

    if (fileSize <= maxFileSizeInBytes) {
      if (picture.path.isNotEmpty) {
        isSizeLimitExceeded = false;
        picturePath = picture.path;
        profilePicture = picturePath;
        image = File(picture.path);
      }
    } else {
      if (picture.path.isNotEmpty) {
        isSizeLimitExceeded = true;
        picturePath = picture.path;
        profilePicture = picturePath;
        image = File(picture.path);
      }
    }
  }

  void onSendProgress(int received, int total) {
    uploadProgressReceived = received;
    uploadProgressTotal = total;
  }

  Future<void> uploadProfilePicture() async {
    String fileName = image!.path.split('/').last;
    late UpdateProfilePictureUseCase updateProfilePicture;
    late Result<CommonEntity> result;
    UpdateProfilePictureParams params = UpdateProfilePictureParams(
      id: id, 
      formData: dio.FormData.fromMap({
        'profile-picture': await dio.MultipartFile.fromFile(
          image!.path,
          filename: fileName
        )
      }),
      onSendProgress: onSendProgress
    );

    updateProfilePicture = UpdateProfilePictureUseCase(
      updateProfileRepository: UpdateProfileRepositoryImplementation()
    );
    Get.dialog(Obx(() => UploadDialog(
      title: 'Uploading your new profile picture', 
      received: uploadProgressReceived, 
      total: uploadProgressTotal
    )));
    result = await updateProfilePicture.call(params);

    if (result.status is Success) {
      Get.until((route) => !Get.isDialogOpen!);
      isProfilePictureUploaded = true;
    } else {
      Get.until((route) => !Get.isDialogOpen!);
      snackbar(
        title: 'Oops!', 
        message: result.message
      );
    }
  }

  Future<void> updateProfile(UpdateProfileParams params) async {
    late UpdateProfileUseCase updateProfile;
    late Result<CommonEntity> result;

    loaderDialog(
      loaderIcon: const SpinKitRing(color: AppColors.primaryColor),
      message: 'Please wait...'
    );
    updateProfile = UpdateProfileUseCase(
      updateProfileRepository: UpdateProfileRepositoryImplementation()
    );
    result = await updateProfile.call(params);

    if (result.status is Success) {
      Get.back();
      Get.offAllNamed(Routes.HOME);
      snackbar(title: 'Yay!', message: result.data.message);
    } else {
      Get.back();
      snackbar(title: 'Oops!', message: result.message);
    }
  }

  Future<void> initiateUpdateProfile() async {
    final isEmailValid = emailFormKey.currentState!.validate();
    final isUsernameValid = usernameFormKey.currentState!.validate();

    UpdateProfileParams paramsWithPassword = UpdateProfileParams(
      id: id,
      email: emailController.text.trim(),
      username: usernameController.text.trim(),
      password: passwordController.text.trim()
    );

    UpdateProfileParams paramsWithoutPassword = UpdateProfileParams(
      id: id,
      email: emailController.text.trim(),
      username: usernameController.text.trim()
    );

    if (!showPasswordForm) {
      if (isEmailValid && isUsernameValid) {
        if (picturePath.isNotEmpty) {
          uploadProfilePicture().then((value) {
            if (isProfilePictureUploaded) {
              updateProfile(paramsWithoutPassword);
            }
          });
        } else {
          updateProfile(paramsWithoutPassword);
        }
      } else {
        if (!isEmailValid && !isUsernameValid) {
          autoValidateEmail = AutovalidateMode.always;
          autoValidateUsername = AutovalidateMode.always;
        } else if (!isEmailValid) {
          autoValidateEmail = AutovalidateMode.always;
        } else if (!isUsernameValid) {
          autoValidateUsername = AutovalidateMode.always;
        }
      }
    } else {
      final isPasswordValid = passwordFormKey.currentState!.validate();
      final isConfirmPasswordValid = confirmPasswordFormKey.currentState!.validate();

      if (isEmailValid && isUsernameValid && isPasswordValid && isConfirmPasswordValid) {
        if (picturePath.isNotEmpty) {
          uploadProfilePicture().then((value) {
            if (isProfilePictureUploaded) {
              updateProfile(paramsWithPassword);
            }
          });
        } else {
          updateProfile(paramsWithPassword);
        }
      } else {
        if (!isEmailValid && !isUsernameValid && !isPasswordValid && !isConfirmPasswordValid) {
          autoValidateEmail = AutovalidateMode.always;
          autoValidateUsername = AutovalidateMode.always;
          autoValidatePassword = AutovalidateMode.always;
          autoValidateConfirmPassword = AutovalidateMode.always;
        } else if (!isEmailValid) {
          autoValidateEmail = AutovalidateMode.always;
        } else if (!isUsernameValid) {
          autoValidateUsername = AutovalidateMode.always;
        } else if (!isPasswordValid) {
          autoValidatePassword = AutovalidateMode.always;
        } else if (!isConfirmPasswordValid) {
          autoValidateConfirmPassword = AutovalidateMode.always;
        }
      }
    }
  }
}
