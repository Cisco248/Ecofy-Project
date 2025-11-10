import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/feature/auth/models/user_model.dart';
import 'package:wms_app/feature/auth/repository/auth_local_repository.dart';
import 'package:wms_app/feature/auth/repository/auth_remote_repository.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  // Create the auth remote repo instance
  late AuthRemoteRepository _authRemoteRepository;
  // Create the auth local repository instance
  late AuthLocalRepository _authLocalRepository;

  @override
  AsyncValue<UserModel>? build() {
    // when repository changes whole build function rebuild
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    return null;
  }

  // Create SharedPreferences Instance for the main.dart file
  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  // Create the Output Function for the dart pattern
  AsyncValue<UserModel> _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    return state = AsyncValue.data(user);
  }

  Future<void> signUpUser({
    required String userFistName,
    required String userLastName,
    required String userEmail,
    required String userPassword,
    required String userConfirmPassword,
    required String userMobileNum,
  }) async {
    // setup the loading screen for the application
    state = AsyncValue.loading();

    final res = await _authRemoteRepository.signUp(
      userFisrtName: userFistName,
      userLastName: userLastName,
      userEmail: userEmail,
      userPassword: userPassword,
      userConfirmPassword: userConfirmPassword,
      userMobileNum: userMobileNum,
    );

    final val = switch (res) {
      // Pass Error to the Async Value Error form the Response
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      // Pass data to Async Value dat for the Response
      Right(value: final r) => _loginSuccess(r),
    };

    if (kDebugMode) {
      debugPrint(val.toString());
    }
  }

  Future<void> signInUser({
    required String userEmail,
    required String userPassword,
  }) async {
    // setup the loading screen for the application
    state = AsyncValue.loading();

    final res = await _authRemoteRepository.signIn(
      userEmail: userEmail,
      userPassword: userPassword,
    );

    final val = switch (res) {
      // Pass Error to the Async Value Error form the Response
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      // Pass data to Async Value dat for the Response
      Right(value: final r) => _loginSuccess(r),
    };

    if (kDebugMode) {
      debugPrint(val.toString());
    }
  }
}
