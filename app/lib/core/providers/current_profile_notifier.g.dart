// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_profile_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentProfileNotifier)
final currentProfileProvider = CurrentProfileNotifierProvider._();

final class CurrentProfileNotifierProvider
    extends $NotifierProvider<CurrentProfileNotifier, ProfileModel?> {
  CurrentProfileNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentProfileNotifierHash();

  @$internal
  @override
  CurrentProfileNotifier create() => CurrentProfileNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileModel?>(value),
    );
  }
}

String _$currentProfileNotifierHash() =>
    r'e93b26839c86340029f9cced13c824b2272abcbb';

abstract class _$CurrentProfileNotifier extends $Notifier<ProfileModel?> {
  ProfileModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProfileModel?, ProfileModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProfileModel?, ProfileModel?>,
              ProfileModel?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
