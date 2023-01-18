class SimpleException extends Error {
  final String? message;
  SimpleException({this.message = "Something went wrong"});
}
