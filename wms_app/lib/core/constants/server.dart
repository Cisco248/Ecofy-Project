class ServerConstant {
  static String serverURL = 'http://10.0.2.2:8000';

  Map<String, String> getHeaders() {
    final headers = {'Content-Type': 'application/json'};
    return headers;
  }
}
