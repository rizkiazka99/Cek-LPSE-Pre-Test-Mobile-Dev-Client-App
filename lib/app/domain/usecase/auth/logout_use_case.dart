import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/auth/auth_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/use_case.dart';

class LogoutUseCase extends UseCase {
  final AuthRepository authRepository;

  LogoutUseCase({ required this.authRepository });

  @override
  Future<Result> call(dynamic params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    } else {
      return authRepository.logout();
    }
  }
}