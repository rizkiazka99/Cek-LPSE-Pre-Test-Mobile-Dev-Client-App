import 'package:ceklpse_pretest_mobiledev/app/domain/entities/auth/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel.fromJson(Map<String, dynamic> json)
      : super(
          status: json["status"],
          message: json["message"],
          accessToken: json["access_token"],
        );
}