// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileRemoteRepository)
const profileRemoteRepositoryProvider = ProfileRemoteRepositoryProvider._();

final class ProfileRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRemoteRepository,
          ProfileRemoteRepository,
          ProfileRemoteRepository
        >
    with $Provider<ProfileRemoteRepository> {
  const ProfileRemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRemoteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRemoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRemoteRepository create(Ref ref) {
    return profileRemoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRemoteRepository>(value),
    );
  }
}

String _$profileRemoteRepositoryHash() =>
    r'ab9f73c2fe0ab94abbbc7ec2740e933d83d963f6';
