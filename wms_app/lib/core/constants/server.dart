import 'package:http/http.dart' as http;

class ServerConstant {
  static const String serverURL = 'http://10.0.2.2:8000';

  static Map<String, String> getHeaders() {
    return {'Content-Type': 'application/json'};
  }

  /// Makes a GET request to the server at the specified endpoint.
  ///
  /// Sends an HTTP GET request to the server using the base URL from
  /// [ServerConstant.serverURL] combined with the provided [endPoint].
  ///
  /// **Parameters:**
  /// * [endPoint] - The API endpoint path (e.g., 'users', 'products/123')
  ///
  /// **Returns:**
  /// A [Future] containing the [http.Response] from the server.
  ///
  /// **Throws:**
  /// * [SocketException] - If there's no internet connection
  /// * [HttpException] - If the HTTP request fails
  /// * [FormatException] - If the response format is invalid
  ///
  /// **Example:**
  /// ```dart
  /// try {
  ///   final response = await ServerConstant.serverGet('users');
  ///   if (response.statusCode == 200) {
  ///     final data = jsonDecode(response.body);
  ///     print('Users: $data');
  ///   } else {
  ///     print('Error: ${response.statusCode}');
  ///   }
  /// } catch (e) {
  ///   print('Request failed: $e');
  /// }
  /// ```
  static Future<void> serverGet(String endPoint) async {
    await http.get(
      Uri.parse('${ServerConstant.serverURL}/$endPoint'),
      headers: ServerConstant.getHeaders(),
    );
  }
}
