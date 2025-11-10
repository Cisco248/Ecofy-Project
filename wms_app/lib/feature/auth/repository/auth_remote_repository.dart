import 'dart:async';
import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/core/constants/server.dart';
import 'package:wms_app/feature/auth/models/user_model.dart';
import 'package:wms_app/utilities/helpers/app_failure.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signUp({
    required String userFisrtName,
    required String userLastName,
    required String userEmail,
    required String userPassword,
    required String userConfirmPassword,
    required String userMobileNum,
  }) async {
    try {
      // Create the Signup Request for the Server
      final responseSignUp = await http.post(
        Uri.parse('${ServerConstant.serverURL}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fname': userFisrtName,
          'lname': userLastName,
          'email': userEmail,
          'password': userPassword,
          'conpassword': userConfirmPassword,
          'mobnum': userMobileNum,
        }),
      );
      //  Decode the User Request
      final userDecode =
          jsonDecode(responseSignUp.body) as Map<String, dynamic>;

      if (responseSignUp.statusCode != 200) {
        // throw TimeoutException('Timeout error!');
        return Left(AppFailure('Error: ${userDecode['detail']}'));
      }

      return Right(UserModel.fromMap(userDecode));
    } catch (e) {
      // if (kDebugMode) {
      //   debugPrint(e.toString());
      // }
      // throw Exception('Connection Error: $e');
      return Left(AppFailure('Connection Error: ${e.toString()}'));
    }
  }

  Future<Either<AppFailure, UserModel>> signIn({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      final responseSignIn = await http
          .post(
            Uri.parse('${ServerConstant.serverURL}/auth/signin'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': userEmail, 'password': userPassword}),
          )
          .timeout(const Duration(seconds: 10));

      final userDec = jsonDecode(responseSignIn.body) as Map<String, dynamic>;

      if (responseSignIn.statusCode != 200) {
        // throw TimeoutException("Timeout Error!");
        return Left(AppFailure('Error: ${userDec['detail']}'));
      }

      // Create the full request with userToken using copy with function
      return Right(
        UserModel.fromMap(userDec['user']).copyWith(token: userDec['token']),
      );
      // Pass the Exception to the catch
    } catch (e) {
      // if (kDebugMode) {
      //   debugPrint(e.toString());
      // }
      // throw Exception('Connection Error: $e');
      return Left(AppFailure('Connection Error: ${e.toString()}'));
    }
  }
}
