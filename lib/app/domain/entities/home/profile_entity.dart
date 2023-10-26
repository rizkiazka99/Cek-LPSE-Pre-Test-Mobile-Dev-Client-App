class ProfileEntity {
  bool status;
  String message;
  Data? data;

  ProfileEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

class Data {
  String id;
  String username;
  String email;
  String password;
  String profilePicture;
  String gender;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.profilePicture,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });
}