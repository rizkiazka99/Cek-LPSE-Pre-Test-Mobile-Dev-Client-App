class LoginEntity {
  bool status;
  String message;
  String? accessToken;

  LoginEntity({
    required this.status,
    required this.message,
    required this.accessToken,
  });
}