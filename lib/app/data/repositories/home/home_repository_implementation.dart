import 'package:ceklpse_pretest_mobiledev/app/data/model/common_model.dart';
import 'package:ceklpse_pretest_mobiledev/app/data/model/home/profile_model.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/home/profile_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/home/home_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/home/delete_account_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/routes/app_pages.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/dio.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/global.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/helpers.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeRepositoryImplementation extends HomeRepository {
  final _dio = DioHelper.init();

  @override
  Future<Result<ProfileEntity>> getProfile() async {
    String endpoint = '/users/profile';

    try {
      final response = await _dio.get(endpoint);
      final profile = ProfileModel.fromJson(response.data);

      return Result.success(profile);
    } on DioException catch(err) {
      debugPrint(err.message);
      if (err.response != null) {
        if (err.response!.statusCode == 404) {
          localStorage.erase();
          Get.offAllNamed(Routes.AUTH);
          snackbar(title: 'Oops!', message: 'Invalid session');

          return Result.error(
            message: err.response!.data['message'],
            code: err.response!.statusCode
          );
        } else {
          return Result.error(
            message: err.response!.data['message'],
            code: err.response!.statusCode
          );
        }
      } else {
        return Result.error(
          message: 'Something went wrong',
          code: -1
        );
      }
    } catch(err) {
      debugPrint(err.toString());
      return Result.error(message: 'Unexpected error occurred');
    }
  }

  @override
  Future<Result<CommonEntity>> deleteAccount({
    required DeleteAccountParams params
  }) async {
    String endpoint = '/users/delete_profile/${params.id}';

    try {
      final response = await _dio.delete(endpoint);
      final deleteAccount = CommonModel.fromJson(response.data);

      return Result.success(deleteAccount);
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
      return Result.error(message: 'Unexpected error occured');
    }
  }
}