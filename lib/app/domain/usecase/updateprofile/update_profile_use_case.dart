import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/updateprofile/update_profile_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/use_case.dart';

class UpdateProfileParams {
  final String id;
  final String email;
  final String username;
  final String? password;

  UpdateProfileParams({
    required this.id,
    required this.email, 
    required this.username, 
    this.password
  });
}

class UpdateProfileUseCase extends UseCase<CommonEntity, UpdateProfileParams> {
  final UpdateProfileRepository updateProfileRepository;

  UpdateProfileUseCase({ required this.updateProfileRepository });

  @override
  Future<Result<CommonEntity>> call(UpdateProfileParams params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    } else {
      return updateProfileRepository.updateProfile(params: params);
    }
  }
}