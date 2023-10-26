import 'package:ceklpse_pretest_mobiledev/app/routes/app_pages.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/constants.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/global.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/helpers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioHelper {
  static Dio init() {
    var dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(minutes: 5),
        receiveTimeout: const Duration(minutes: 5),
        followRedirects: false,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'access_token': localStorage.read('access_token') ?? ''
        }
      )
    );

    final interceptors = InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        if (error.response!.statusCode == 401) {
          snackbar(
            title: 'Oops!', 
            message: 'Access token wasn\'t found'
          );
          localStorage.erase();
          Get.offAllNamed(Routes.AUTH);
        }

        return handler.next(error);
      }
    );

    dio.interceptors.add(interceptors);

    return dio;
  }

  Dio dio = init();
  
}