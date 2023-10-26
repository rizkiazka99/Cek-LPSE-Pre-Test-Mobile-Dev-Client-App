import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/auth/auth_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/use_case.dart';

class RegisterParams {
  final String email;
  final String username;
  final String password;
  final String gender;

  RegisterParams({
    required this.email, 
    required this.username, 
    required this.password, 
    required this.gender
  });
}

class RegisterUseCase extends UseCase<CommonEntity, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUseCase({ required this.authRepository });

  @override
  Future<Result<CommonEntity>> call(RegisterParams params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    } else {
      return authRepository.register(params: params);
    }
  }
}