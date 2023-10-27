import 'package:ceklpse_pretest_mobiledev/app/data/repositories/auth/auth_repository_implementation.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/auth/login_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/auth/login_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/auth/register_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/routes/app_pages.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/helpers.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  ScrollController scrollController = ScrollController();

  // Login
  TextEditingController usernameLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  final usernameLoginFormKey = GlobalKey<FormState>();
  final passwordLoginFormKey = GlobalKey<FormState>();

  var autoValidateUsernameLogin = AutovalidateMode.disabled;
  var autoValidatePasswordLogin = AutovalidateMode.disabled;

  // Register
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final emailFormKey = GlobalKey<FormState>();
  final usernameRegisterFormKey = GlobalKey<FormState>();
  final passwordRegisterFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();

  var autoValidateEmail = AutovalidateMode.disabled;
  var autoValidateUsernameRegister = AutovalidateMode.disabled;
  var autoValidatePasswordRegister = AutovalidateMode.disabled;
  var autoValidateConfirmPassword = AutovalidateMode.disabled;

  RxInt _selectedAuthOption = 0.obs;
  RxBool _isLoginPasswordVisible = true.obs;
  RxBool _isRegisterPasswordVisible = true.obs;
  RxBool _isConfirmPasswordVisible = true.obs;
  RxString _selectedGender = 'Male'.obs;
  Rxn<LoginEntity> _loginResult = Rxn<LoginEntity>();
  Rxn<CommonEntity> _registerResult = Rxn<CommonEntity>();
  
  int get selectedAuthOption => _selectedAuthOption.value;
  bool get isLoginPasswordVisible => _isLoginPasswordVisible.value;
  bool get isRegisterPasswordVisible => _isRegisterPasswordVisible.value;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;
  String get selectedGender => _selectedGender.value;
  LoginEntity? get loginResult => _loginResult.value;
  CommonEntity? get registerResult => _registerResult.value;

  set selectedAuthOption(int selectedAuthOption) =>
      this._selectedAuthOption.value = selectedAuthOption;
  set isLoginPasswordVisible(bool isLoginPasswordVisible) =>
      this._isLoginPasswordVisible.value = isLoginPasswordVisible;
  set isRegisterPasswordVisible(bool isRegisterPasswordVisible) =>
      this._isRegisterPasswordVisible.value = isRegisterPasswordVisible;
  set isConfirmPasswordVisible(bool isConfirmPasswordVisible) =>
      this._isConfirmPasswordVisible.value = isConfirmPasswordVisible;
  set selectedGender(String selectedGender) =>
      this._selectedGender.value = selectedGender;
  set loginResult(LoginEntity? loginResult) =>
      this._loginResult.value = loginResult;
  set registerResult(CommonEntity? registerResult) =>
      this._registerResult.value = registerResult;

  List<String> genders = ['Male', 'Female'];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    usernameLoginController.dispose();
    passwordLoginController.dispose();
    emailController.dispose();
    usernameRegisterController.dispose();
    passwordRegisterController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    final isUsernameValid = usernameLoginFormKey.currentState!.validate();
    final isPasswordValid = passwordLoginFormKey.currentState!.validate();

    if (isUsernameValid && isPasswordValid) {
      late LoginUseCase login;
      late Result<LoginEntity> result;
      LoginParams params = LoginParams(
        username: usernameLoginController.text.trim(), 
        password: passwordLoginController.text.trim() 
      );

      loaderDialog(
        loaderIcon: const SpinKitRing(color: AppColors.primaryColor), 
        message: 'Please wait...'
      );
      login = LoginUseCase(authRepository: AuthRepositoryImplementation());
      result = await login.call(params);

      if (result.status is Success) {
        Get.back();
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.back();
        snackbar(
          title: 'Oops!', 
          message: result.message
        );
      }
    } else {
      if (!isUsernameValid && !isPasswordValid) {
        autoValidateUsernameLogin = AutovalidateMode.always;
        autoValidatePasswordLogin = AutovalidateMode.always;
      } else if (!isUsernameValid) {
        autoValidateUsernameLogin = AutovalidateMode.always;
      } else if (!isPasswordValid) {
        autoValidatePasswordLogin = AutovalidateMode.always;
      }
    }
  }

  Future<void> register() async {
    final isEmailValid = emailFormKey.currentState!.validate();
    final isUsernameRegisterValid = usernameRegisterFormKey.currentState!.validate();
    final isPasswordRegisterValid = passwordRegisterFormKey.currentState!.validate();
    final isConfirmPasswordValid = confirmPasswordFormKey.currentState!.validate();

    if (isEmailValid && isUsernameRegisterValid && isPasswordRegisterValid && isConfirmPasswordValid) {
      late RegisterUseCase register;
      late Result<CommonEntity> result;
      RegisterParams params = RegisterParams(
        email: emailController.text.trim(), 
        username: usernameRegisterController.text.trim(), 
        password: passwordRegisterController.text.trim(), 
        gender: selectedGender
      );
      debugPrint(params.email);
      debugPrint(params.username);
      debugPrint(params.password);
      debugPrint(params.gender);

      loaderDialog(
        loaderIcon: const SpinKitRing(color: AppColors.primaryColor), 
        message: 'Please wait...'
      );
      register = RegisterUseCase(authRepository: AuthRepositoryImplementation());
      result = await register.call(params);

      if (result.status is Created) {
        Get.back();
        emailController.clear();
        usernameRegisterController.clear();
        passwordRegisterController.clear();
        confirmPasswordController.clear();
        selectedGender = genders[0];
        selectedAuthOption = 0;
        snackbar(
          title: 'Yay!', 
          message: result.data.message
        );
      } else {
        Get.back();
        snackbar(
          title: 'Oops!', 
          message: result.message
        );
      }
    } else {
      if (!isEmailValid && !isUsernameRegisterValid && !isPasswordRegisterValid && !isConfirmPasswordValid) {
        autoValidateEmail = AutovalidateMode.always;
        autoValidateUsernameRegister = AutovalidateMode.always;
        autoValidatePasswordRegister = AutovalidateMode.always;
        autoValidateConfirmPassword = AutovalidateMode.always;
      } else if (!isEmailValid) {
        autoValidateEmail = AutovalidateMode.always;
      } else if (!isUsernameRegisterValid) {
        autoValidateUsernameRegister = AutovalidateMode.always;
      } else if (!isPasswordRegisterValid) {
        autoValidatePasswordRegister = AutovalidateMode.always;
      } else if (!isConfirmPasswordValid) {
        autoValidateConfirmPassword = AutovalidateMode.always;
      }
    }
  }
}
