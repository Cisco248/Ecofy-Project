import 'dart:async';
import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/core/constants/server.dart';
import 'package:wms_app/feature/profile/models/profile_model.dart';
import 'package:wms_app/utilities/helpers/app_failure.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';

part 'profile_remote_repository.g.dart';

@riverpod
ProfileRemoteRepository profileRemoteRepository(Ref ref) {
  return ProfileRemoteRepository();
}

class ProfileRemoteRepository {
  Future<Either<AppFailure, ProfileModel>> getUserData(String token) async {
    try {
      final responeGetDta = await http.get(
        Uri.parse('${ServerConstant.serverURL}/auth/profile'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      final userDecode = jsonDecode(responeGetDta.body) as Map<String, dynamic>;

      if (responeGetDta.statusCode == 200) {
        DebugPrint(userDecode, "[PROFILE] Response Status").log;
        return Right(ProfileModel.fromMap(userDecode));
      }

      return Left(AppFailure("Error: $userDecode"));
    } catch (e) {
      return Left(AppFailure('Error: ${e.toString()}'));
    }
  }
}
