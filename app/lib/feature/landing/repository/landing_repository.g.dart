// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landing_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(landingRepository)
final landingRepositoryProvider = LandingRepositoryProvider._();

final class LandingRepositoryProvider
    extends
        $FunctionalProvider<
          LandingRepository,
          LandingRepository,
          LandingRepository
        >
    with $Provider<LandingRepository> {
  LandingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'landingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$landingRepositoryHash();

  @$internal
  @override
  $ProviderElement<LandingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LandingRepository create(Ref ref) {
    return landingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LandingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LandingRepository>(value),
    );
  }
}

String _$landingRepositoryHash() => r'f3fd532451195e312fd67acee57ce938dad78b7c';
