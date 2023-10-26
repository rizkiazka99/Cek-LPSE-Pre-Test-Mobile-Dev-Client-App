import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/updateprofile/update_profile_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/use_case.dart';

class VerifyPasswordParams {
  final String username;
  final String password;

  VerifyPasswordParams({
    required this.username,
    required this.password 
  });
}

class VerifyPasswordUseCase extends UseCase<CommonEntity, VerifyPasswordParams> {
  final UpdateProfileRepository updateProfileRepository;

  VerifyPasswordUseCase({ required this.updateProfileRepository });

  @override
  Future<Result<CommonEntity>> call(VerifyPasswordParams params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    } else {
      return updateProfileRepository.verifyPassword(params: params);
    }
  }
}