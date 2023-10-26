import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/updateprofile/update_profile_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/use_case.dart';
import 'package:dio/dio.dart';

class UpdateProfilePictureParams {
  final String id;
  final FormData formData;
  final dynamic onSendProgress;

  UpdateProfilePictureParams({
    required this.id,
    required this.formData,
    required this.onSendProgress
  });
}

class UpdateProfilePictureUseCase extends UseCase<CommonEntity, UpdateProfilePictureParams> {
  final UpdateProfileRepository updateProfileRepository;

  UpdateProfilePictureUseCase({ required this.updateProfileRepository });

  @override
  Future<Result<CommonEntity>> call(UpdateProfilePictureParams params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    } else {
      return updateProfileRepository.updateProfilePicture(params: params);
    }
  }
}