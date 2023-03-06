class ResponseMessage {
  static const String success = "success"; // success with data
  static const String noContent =
      "success"; // success with no data (no content)
  static const String badRequest =
      "Bad request, Try again later"; // failure, API rejected request
  static const String unauthorized =
      "User is unauthorised, please login again"; // failure, user is not authorised
  static const String forbidden =
      "Forbidden request, Try again later"; //  failure, API rejected request
  static const String internalServerError =
      "Some thing went wrong, Try again later"; // failure, crash in server side
  static const String notFound = "Not Found"; // failure, crash in server side

  // local status code
  static const String connectTimeout = "Time out error, Try again later";
  static const String cancel = "Request was cancelled, Try again later";
  static const String recieveTimeout = "Time out error, Try again later";
  static const String sendTimeout = "Time out error, Try again later";
  static const String cacheError = "Cache error, Try again later";
  static const String storedStorageError = "Storage error, Try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
  static const String defaultError = "Some thing went wrong, Try again later";
}
