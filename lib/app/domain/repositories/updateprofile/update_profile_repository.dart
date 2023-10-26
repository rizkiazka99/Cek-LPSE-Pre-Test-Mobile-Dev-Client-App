import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/updateprofile/update_profile_picture_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/updateprofile/update_profile_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/updateprofile/verify_password_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';

abstract class UpdateProfileRepository {
  Future<Result<CommonEntity>> updateProfile({
    required UpdateProfileParams params
  });

  Future<Result<CommonEntity>> updateProfilePicture({
    required UpdateProfilePictureParams params
  });

  Future<Result<CommonEntity>> verifyPassword({
    required VerifyPasswordParams params
  });
}