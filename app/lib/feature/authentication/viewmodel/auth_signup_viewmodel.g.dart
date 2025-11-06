// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_signup_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthSignupViewmodel)
const authSignupViewmodelProvider = AuthSignupViewmodelProvider._();

final class AuthSignupViewmodelProvider
    extends
        $NotifierProvider<AuthSignupViewmodel, AsyncValue<UserSignUpModels>?> {
  const AuthSignupViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSignupViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSignupViewmodelHash();

  @$internal
  @override
  AuthSignupViewmodel create() => AuthSignupViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<UserSignUpModels>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<UserSignUpModels>?>(
        value,
      ),
    );
  }
}

String _$authSignupViewmodelHash() =>
    r'8e55ab1fd6a312c9963f8d7f424d31505eeffcc6';

abstract class _$AuthSignupViewmodel
    extends $Notifier<AsyncValue<UserSignUpModels>?> {
  AsyncValue<UserSignUpModels>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<UserSignUpModels>?,
              AsyncValue<UserSignUpModels>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<UserSignUpModels>?,
                AsyncValue<UserSignUpModels>?
              >,
              AsyncValue<UserSignUpModels>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
