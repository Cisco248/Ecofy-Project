import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:e_wms_mobile/core/constants/server.dart';
import 'package:e_wms_mobile/feature/authentication/models/user_signin_models.dart';
import 'package:e_wms_mobile/feature/authentication/models/user_signup_models.dart';
import 'package:e_wms_mobile/utilities/helpers/app_failure.dart';
import 'package:e_wms_mobile/feature/authentication/schemas/auth_schema.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<AppFailure, UserSignInModels>> signIn(
    AuthSignInSchema userSignIn,
  ) async {
    try {
      final res = await http
          .post(
            Uri.parse('${ServerConstant.serverURL}/auth/signin'),
            headers: ServerConstant().getHeaders(),
            body: jsonEncode(userSignIn.toJson()),
          )
          .timeout(const Duration(seconds: 15));

      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode != 201) {
        return Left(AppFailure(resBodyMap['detail'] ?? 'Sign in failed'));
      }
      return Right(UserSignInModels.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure('Unexpected error: ${e.toString()}'));
    }
  }

  Future<Either<AppFailure, UserSignUpModels>> signUp(
    AuthSignUpSchema userSignUp,
  ) async {
    try {
      final res = await http
          .post(
            Uri.parse('${ServerConstant.serverURL}/auth/signup'),
            headers: ServerConstant().getHeaders(),
            body: jsonEncode(userSignUp.toJson()),
          )
          .timeout(const Duration(seconds: 15));

      final resDataMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode != 201) {
        return Left(AppFailure(resDataMap['detail'] ?? 'Sign in failed'));
      }

      return Right(UserSignUpModels.fromMap(resDataMap));
    } on TimeoutException {
      return Left(AppFailure('Connection timeout. Please try again.'));
    } on SocketException {
      return Left(
        AppFailure('No internet connection. Please check your network.'),
      );
    } on FormatException {
      return Left(AppFailure('Invalid response format from server.'));
    } catch (e) {
      return Left(AppFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
