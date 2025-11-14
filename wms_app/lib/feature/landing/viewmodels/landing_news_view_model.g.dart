// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landing_news_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LandingNewsViewModel)
const landingNewsViewModelProvider = LandingNewsViewModelProvider._();

final class LandingNewsViewModelProvider
    extends $NotifierProvider<LandingNewsViewModel, AsyncValue<NewsModel>?> {
  const LandingNewsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'landingNewsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$landingNewsViewModelHash();

  @$internal
  @override
  LandingNewsViewModel create() => LandingNewsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<NewsModel>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<NewsModel>?>(value),
    );
  }
}

String _$landingNewsViewModelHash() =>
    r'5107052afd4c616ca5436ede7e5cc9540a9483be';

abstract class _$LandingNewsViewModel
    extends $Notifier<AsyncValue<NewsModel>?> {
  AsyncValue<NewsModel>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<NewsModel>?, AsyncValue<NewsModel>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NewsModel>?, AsyncValue<NewsModel>?>,
              AsyncValue<NewsModel>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
