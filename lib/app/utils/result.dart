abstract class Status {
  static var success = Success();
  static var created = Created();
  static var noInternet = NoInternet();
  static var error = Error();
  static var tokenNotFound = TokenNotFound();
}

class Success extends Status {}
class Created extends Status {}
class NoInternet extends Status {}
class Error extends Status {}
class TokenNotFound extends Status {}

class Result<T> {
  late T data;
  late Status status;
  int? code;
  String message;

  Result.success(
    this.data, {
      this.message = "",
      this.code = 200 
    }
  ) : status = Status.success;

  Result.created(
    this.data, {
      this.message = "",
      this.code = 201 
    }
  ) : status = Status.created;

  Result.noInternet({
    this.message = "No Internet Connection",
    this.code = -1
  }) : status = Status.noInternet;

  Result.error({
    Status? status,
    this.message = "",
    this.code = -1
  }) : status = status ?? Status.error;

  Result.tokenNotFound({
    this.message = "",
    this.code = 401
  }) : status = Status.tokenNotFound;
}