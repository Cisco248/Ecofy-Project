// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landing_task_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LandingTaskViewModel)
const landingTaskViewModelProvider = LandingTaskViewModelProvider._();

final class LandingTaskViewModelProvider
    extends
        $NotifierProvider<LandingTaskViewModel, AsyncValue<List<TaskModel>>?> {
  const LandingTaskViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'landingTaskViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$landingTaskViewModelHash();

  @$internal
  @override
  LandingTaskViewModel create() => LandingTaskViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<TaskModel>>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<TaskModel>>?>(value),
    );
  }
}

String _$landingTaskViewModelHash() =>
    r'c50ef724693f8ae3e00127c9f7b7e655e45a2837';

abstract class _$LandingTaskViewModel
    extends $Notifier<AsyncValue<List<TaskModel>>?> {
  AsyncValue<List<TaskModel>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<TaskModel>>?, AsyncValue<List<TaskModel>>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TaskModel>>?,
                AsyncValue<List<TaskModel>>?
              >,
              AsyncValue<List<TaskModel>>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
