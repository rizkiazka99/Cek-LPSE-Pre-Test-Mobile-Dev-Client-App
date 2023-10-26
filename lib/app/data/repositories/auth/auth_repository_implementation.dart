import 'package:ceklpse_pretest_mobiledev/app/data/model/auth/login_model.dart';
import 'package:ceklpse_pretest_mobiledev/app/data/model/common_model.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/auth/login_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/auth/auth_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/auth/login_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/auth/register_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/routes/app_pages.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/dio.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/global.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/helpers.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthRepositoryImplementation extends AuthRepository {
  final _dio = DioHelper.init();

  @override
  Future<Result<LoginEntity>> login({
    required LoginParams params
  }) async {
    String endpoint = '/users/login';
    final data = {
      'username': params.username,
      'password': params.password
    };

    try {
      final response = await _dio.post(
        endpoint,
        data: data
      );
      final loginResponse = LoginModel.fromJson(response.data);
      localStorage.write('access_token', loginResponse.accessToken);

      return Result.success(loginResponse);
    } on DioException catch(err) {
      debugPrint(err.message);
      return Result.error(
        message: err.response != null 
            ? err.response?.data['message'] 
            : 'Something went wrong',
        code: err.response != null
            ? err.response?.statusCode
            : -1
      );
    } catch(err) {
      debugPrint(err.toString());
      return Result.error(message: 'Unexpected error occurred');
    }
  }

  @override
  Future<Result<CommonEntity>> register({
    required RegisterParams params
  }) async {
    String endpoint = '/users/register';
    final data = {
      "email": params.email,
      "username": params.username,
      "password": params.password,
      "gender": params.gender
    };

    try {
      final response = await _dio.post(
        endpoint,
        data: data
      );
      final registerResponse = CommonModel.fromJson(response.data);

      return Result.created(registerResponse);
    } on DioException catch(err) {
      debugPrint(err.message);
      return Result.error(
        message: err.response != null 
            ? err.response?.data['message'] 
            : 'Something went wrong',
        code: err.response != null
            ? err.response?.statusCode
            : -1
      );
    } catch(err) {
      debugPrint(err.toString());
      return Result.error(message: 'Unexpected error occurred');
    }
  }

  @override
  logout() {
    dynamic data = {
      'message': 'Thank you, until we meet again!'
    };

    try {
      localStorage.erase();
      Get.offAllNamed(Routes.AUTH);

      return Result.success(
        data, 
        message: data['message']
      );
    } catch(err) {
      debugPrint(err.toString());
      snackbar(
        title: 'Oops!', 
        message: 'Something went wrong'
      );
    }
  }
}