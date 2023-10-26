import 'package:ceklpse_pretest_mobiledev/app/data/model/common_model.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/updateprofile/update_profile_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/updateprofile/update_profile_picture_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/updateprofile/update_profile_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/updateprofile/verify_password_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/dio.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UpdateProfileRepositoryImplementation extends UpdateProfileRepository {
  final _dio = DioHelper.init();

  @override
  Future<Result<CommonEntity>> updateProfile({
    required UpdateProfileParams params
  }) async {
    String endpoint = '/users/update_profile/${params.id}';
    final dataWithPassword = {
      'email': params.email,
      'username': params.username,
      'password': params.password
    };
    final dataWithoutPassword = {
      'email': params.email,
      'username': params.username
    };

    try {
      final response = await _dio.put(
        endpoint,
        data: params.password != null
            ? dataWithPassword
            : dataWithoutPassword
      );
      final updateProfileResponse = CommonModel.fromJson(response.data);

      return Result.success(updateProfileResponse);
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
  Future<Result<CommonEntity>> updateProfilePicture({
    required UpdateProfilePictureParams params
  }) async {
    String endpoint = '/users/update_profile/${params.id}';
    final data = params.formData;

    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        onSendProgress: params.onSendProgress
      );
      final updateProfileResponse = CommonModel.fromJson(response.data);

      return Result.success(updateProfileResponse);
    } on DioException catch(err) {
      debugPrint(err.message);
      debugPrint(err.error.toString());
      return Result.error(
        message: err.response != null 
            ? err.response?.data['message'] 
            : 'Failed to update your profile picture',
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
  Future<Result<CommonEntity>> verifyPassword({
    required VerifyPasswordParams params
  }) async {
    String endpoint = '/users/verify_password';
    final data = {
      'username': params.username,
      'password': params.password,
    };

    try {
      final response = await _dio.post(
        endpoint,
        data: data
      );
      final verifyPasswordResponse = CommonModel.fromJson(response.data);

      return Result.success(verifyPasswordResponse);
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
}