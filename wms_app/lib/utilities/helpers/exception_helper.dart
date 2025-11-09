/// Exception used for authentication and API-related issues
class AuthException implements Exception {
  final String message;
  final int? statusCode;

  AuthException(this.message, [this.statusCode]);

  @override
  String toString() {
    if (statusCode != null) {
      return 'AuthException ($statusCode): $message';
    }
    return 'AuthException: $message';
  }
}

/// Exception used for UI or Widget-related logic errors
class WidgetException implements Exception {
  final String message;

  WidgetException(this.message);

  @override
  String toString() => 'WidgetException: $message';
}
