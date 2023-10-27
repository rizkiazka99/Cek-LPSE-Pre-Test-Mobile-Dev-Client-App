import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';
import 'package:ceklpse_pretest_mobiledev/app/domain/repositories/home/home_repository.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/result.dart';
import 'package:ceklpse_pretest_mobiledev/app/utils/use_case.dart';

class DeleteAccountParams {
  final String id;

  DeleteAccountParams({
    required this.id
  });
}

class DeleteAccountUseCase extends UseCase<CommonEntity, DeleteAccountParams> {
  final HomeRepository homeRepository;

  DeleteAccountUseCase({ required this.homeRepository });

  @override
  Future<Result<CommonEntity>> call(DeleteAccountParams params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    } else {
      return homeRepository.deleteAccount(params: params);
    }
  }
}