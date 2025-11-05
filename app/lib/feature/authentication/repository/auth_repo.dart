import 'dart:convert';
import 'package:e_wms_mobile/utilities/helpers/app_failure.dart';
import 'package:e_wms_mobile/utilities/helpers/exception_helper.dart';
import 'package:e_wms_mobile/feature/authentication/schemas/auth_schema.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<AppFailure, Map<String, dynamic>>> signIn(
    AuthSignInModel userSignIn,
  ) async {
    try {
      final res = await http
          .post(
            Uri.parse('http://10.0.2.2:8000/auth/signin'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(userSignIn.toJson()),
          )
          .timeout(const Duration(seconds: 5));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        return Right(data);
      } else {
        final error = jsonDecode(res.body);
        return Left(AppFailure(error['detail'] ?? 'Sign in failed'));
      }
    } catch (e) {
      return Left(AppFailure('Unexpected error: ${e.toString()}'));
    }
  }

  Future<void> signUp(AuthSignUpSchema userSignUp) async {
    try {
      await http.post(
        Uri.parse('http://10.0.2.2:8000/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userSignUp.toJson()),
      );
    } catch (e) {
      throw AuthException('Unexpected Error! Try Again Later!', 500);
    }
  }
}
