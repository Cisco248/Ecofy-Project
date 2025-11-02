class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class WidgetException implements Exception {
  final String message;
  WidgetException(this.message);
}
