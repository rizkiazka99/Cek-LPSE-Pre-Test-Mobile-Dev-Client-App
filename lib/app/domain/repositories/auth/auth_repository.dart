import 'package:ceklpse_pretest_mobiledev/app/domain/entities/auth/login_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/auth/login_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/auth/register_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';

abstract class AuthRepository {
  Future<Result<LoginEntity>> login({
    required LoginParams params
  });

  Future<Result<CommonEntity>> register({
    required RegisterParams params
  });

  logout();
}