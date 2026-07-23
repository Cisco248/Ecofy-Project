// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DiscoverViewModel)
final discoverViewModelProvider = DiscoverViewModelProvider._();

final class DiscoverViewModelProvider
    extends
        $NotifierProvider<DiscoverViewModel, AsyncValue<List<DiscoverModel>>?> {
  DiscoverViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverViewModelHash();

  @$internal
  @override
  DiscoverViewModel create() => DiscoverViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<DiscoverModel>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<DiscoverModel>>?>(
        value,
      ),
    );
  }
}

String _$discoverViewModelHash() => r'e7626c8edc5ff670dfbeb60e0db1dd69b42c1b41';

abstract class _$DiscoverViewModel
    extends $Notifier<AsyncValue<List<DiscoverModel>>?> {
  AsyncValue<List<DiscoverModel>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DiscoverModel>>?,
              AsyncValue<List<DiscoverModel>>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DiscoverModel>>?,
                AsyncValue<List<DiscoverModel>>?
              >,
              AsyncValue<List<DiscoverModel>>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
