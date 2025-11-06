import 'package:e_wms_mobile/feature/authentication/models/user_signup_models.dart';
import 'package:e_wms_mobile/feature/authentication/repository/auth_repo.dart';
import 'package:e_wms_mobile/feature/authentication/schemas/auth_schema.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_signup_viewmodel.g.dart';

@riverpod
class AuthSignupViewmodel extends _$AuthSignupViewmodel {
  final AuthRemoteRepository _authRemoteRepository = AuthRemoteRepository();
  @override
  AsyncValue<UserSignUpModels>? build() {
    return null;
  }

  Future<void> signUpUser({
    required String userFirstName,
    required String userLastName,
    required String userEmail,
    required String userPassword,
    required String userConfirmPassword,
    required String userMobileNum,
  }) async {
    state = const AsyncValue.loading();

    // Create the schema with correct field names
    final regUser = AuthSignUpSchema.fromUserInput(
      userFirstName: userFirstName,
      userLastName: userLastName,
      userEmail: userEmail,
      userPassword: userPassword,
      userConfirmPassword: userConfirmPassword,
      userMobileNum: userMobileNum,
    );

    final res = await _authRemoteRepository.signUp(regUser);

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
