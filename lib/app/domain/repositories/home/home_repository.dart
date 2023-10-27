import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/entities/home/profile_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/usecase/home/delete_account_use_case.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';

abstract class HomeRepository {
  Future<Result<ProfileEntity>> getProfile();

  Future<Result<CommonEntity>> deleteAccount({
    required DeleteAccountParams params
  });
}