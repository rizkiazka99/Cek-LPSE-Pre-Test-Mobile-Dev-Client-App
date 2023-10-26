import 'package:ceklpse_pretest_mobiledev/app/domain/entities/common_entity.dart';

class CommonModel extends CommonEntity {
  CommonModel.fromJson(Map<String, dynamic> json)
      : super(
          status: json["status"],
          message: json["message"],
        );
}