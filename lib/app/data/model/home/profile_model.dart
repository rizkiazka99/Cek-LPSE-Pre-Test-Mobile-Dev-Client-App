import 'package:ceklpse_pretest_mobiledev/app/domain/entities/home/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel.fromJson(Map<String, dynamic> json)
      : super(
          status: json["status"],
          message: json["message"],
          data: json["data"] != null
              ? DataModel.fromJson(json["data"])
              : null,
        );
}

class DataModel extends Data {
  DataModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json["id"],
          username: json["username"],
          email: json["email"],
          password: json["password"],
          profilePicture: json["profile_picture"],
          gender: json["gender"],
          createdAt: DateTime.parse(json["createdAt"]),
          updatedAt: DateTime.parse(json["updatedAt"])
        );
}