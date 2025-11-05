import 'package:http/http.dart' as http;

Future<void> profileGet() async {
  await http.get(
    Uri.parse('http://10.0.2.2:8000/profile'),
    headers: {'Content-Type': 'application/json'},
  );
}
