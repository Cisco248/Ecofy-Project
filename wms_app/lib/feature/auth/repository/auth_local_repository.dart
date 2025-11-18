import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(Ref ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  final _key = 'x-auth-token';
  static late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  setToken(String? token) async {
    if (token != null) {
      await _sharedPreferences.setString(_key, token);
    }
  }

  String? getToken() => _sharedPreferences.getString(_key);

  Future<void> logOut() async => await _sharedPreferences.clear();
}
