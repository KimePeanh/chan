class CustomException implements Exception {
  final String message;

  CustomException({this.message = 'Unknown error occurred. '});
  static signInException({required int statusCode}) {
    throw Exception("wrongCredential");
  }

  static registerException({required int statusCode}) {
    if (statusCode == 400) {
      throw Exception("Phone number has been registed already!");
    } else {
      throw Exception("Unable to register.");
    }
  }

  static generalException({String message = "Error Connection."}) {
    throw Exception(message);
  }

  static noInternet({String message = "No Internet connection."}) {
    throw Exception(message);
  }
}
