import 'package:ceklpse_pretest_mobiledev/app/domain/entities/auth/login_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/auth/auth_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/use_case.dart';

class LoginParams {
  final String username;
  final String password;

  LoginParams({
    required this.username, 
    required this.password
  });
}

class LoginUseCase extends UseCase<LoginEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({ required this.authRepository });

  @override
  Future<Result<LoginEntity>> call(LoginParams params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    } else {
      return authRepository.login(params: params);
    }
  }
}