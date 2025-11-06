// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_signin_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthSignInViewmodel)
const authSignInViewmodelProvider = AuthSignInViewmodelProvider._();

final class AuthSignInViewmodelProvider
    extends
        $NotifierProvider<AuthSignInViewmodel, AsyncValue<UserSignInModels>?> {
  const AuthSignInViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSignInViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSignInViewmodelHash();

  @$internal
  @override
  AuthSignInViewmodel create() => AuthSignInViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<UserSignInModels>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<UserSignInModels>?>(
        value,
      ),
    );
  }
}

String _$authSignInViewmodelHash() =>
    r'df1318faddad283e1336f68f9232fc193387cb6b';

abstract class _$AuthSignInViewmodel
    extends $Notifier<AsyncValue<UserSignInModels>?> {
  AsyncValue<UserSignInModels>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<UserSignInModels>?,
              AsyncValue<UserSignInModels>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<UserSignInModels>?,
                AsyncValue<UserSignInModels>?
              >,
              AsyncValue<UserSignInModels>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
