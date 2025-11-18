// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landing_announce_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LandingAnnounceViewModel)
const landingAnnounceViewModelProvider = LandingAnnounceViewModelProvider._();

final class LandingAnnounceViewModelProvider
    extends
        $NotifierProvider<
          LandingAnnounceViewModel,
          AsyncValue<List<AnnounceModel>>?
        > {
  const LandingAnnounceViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'landingAnnounceViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$landingAnnounceViewModelHash();

  @$internal
  @override
  LandingAnnounceViewModel create() => LandingAnnounceViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<AnnounceModel>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<AnnounceModel>>?>(
        value,
      ),
    );
  }
}

String _$landingAnnounceViewModelHash() =>
    r'51b3162eaebdc632c87b594003a2498a2a1c7e62';

abstract class _$LandingAnnounceViewModel
    extends $Notifier<AsyncValue<List<AnnounceModel>>?> {
  AsyncValue<List<AnnounceModel>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<AnnounceModel>>?,
              AsyncValue<List<AnnounceModel>>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AnnounceModel>>?,
                AsyncValue<List<AnnounceModel>>?
              >,
              AsyncValue<List<AnnounceModel>>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
