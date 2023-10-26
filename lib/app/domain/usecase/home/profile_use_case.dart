import 'package:ceklpse_pretest_mobiledev/app/domain/entities/home/profile_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/home/home_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/use_case.dart';

class ProfileUseCase extends UseCase {
  final HomeRepository homeRepository;

  ProfileUseCase({ required this.homeRepository });

  @override
  Future<Result<ProfileEntity>> call(dynamic params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    } else {
      return homeRepository.getProfile();
    }
  }
}