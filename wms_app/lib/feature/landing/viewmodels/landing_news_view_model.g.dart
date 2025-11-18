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
    extends
        $NotifierProvider<LandingNewsViewModel, AsyncValue<List<NewsModel>>?> {
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
  Override overrideWithValue(AsyncValue<List<NewsModel>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<NewsModel>>?>(value),
    );
  }
}

String _$landingNewsViewModelHash() =>
    r'ae8061996c141c9f37d5fa75dfefd5ffd49271bf';

abstract class _$LandingNewsViewModel
    extends $Notifier<AsyncValue<List<NewsModel>>?> {
  AsyncValue<List<NewsModel>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<NewsModel>>?, AsyncValue<List<NewsModel>>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<NewsModel>>?,
                AsyncValue<List<NewsModel>>?
              >,
              AsyncValue<List<NewsModel>>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
