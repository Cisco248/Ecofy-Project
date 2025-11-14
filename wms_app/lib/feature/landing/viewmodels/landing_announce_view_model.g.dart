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
          AsyncValue<AnnounceModel>?
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
  Override overrideWithValue(AsyncValue<AnnounceModel>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<AnnounceModel>?>(value),
    );
  }
}

String _$landingAnnounceViewModelHash() =>
    r'b14e04b8f3d3ef5d327ceddc1a8cdc715a39736f';

abstract class _$LandingAnnounceViewModel
    extends $Notifier<AsyncValue<AnnounceModel>?> {
  AsyncValue<AnnounceModel>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<AnnounceModel>?, AsyncValue<AnnounceModel>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<AnnounceModel>?,
                AsyncValue<AnnounceModel>?
              >,
              AsyncValue<AnnounceModel>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
