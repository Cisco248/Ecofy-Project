import 'package:e_wms_mobile/feature/authentication/models/user_signin_models.dart';
import 'package:e_wms_mobile/feature/authentication/repository/auth_repo.dart';
import 'package:e_wms_mobile/feature/authentication/schemas/auth_schema.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_signin_viewmodel.g.dart';

@riverpod
class AuthSignInViewmodel extends _$AuthSignInViewmodel {
  final AuthRemoteRepository _authRemoteRepository = AuthRemoteRepository();
  @override
  AsyncValue<UserSignInModels>? build() {
    return null;
  }

  Future<void> signInUser({
    required String userEmail,
    required String userPassword,
  }) async {
    state = const AsyncValue.loading();
    final loginUser = AuthSignInSchema(
      userEmail: userEmail,
      userPassword: userPassword,
    );

    final res = await _authRemoteRepository.signIn(loginUser);

    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      Right(value: final r) => state = AsyncValue.data(r),
    };

    print(val);
  }
}
