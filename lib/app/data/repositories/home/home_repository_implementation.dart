import 'package:ceklpse_pretest_mobiledev/app/data/model/home/profile_model.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/home/profile_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/home/home_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/dio.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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