import 'package:ceklpse_pretest_mobiledev/app/domain/entities/home/profile_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';

abstract class HomeRepository {
  Future<Result<ProfileEntity>> getProfile();
}