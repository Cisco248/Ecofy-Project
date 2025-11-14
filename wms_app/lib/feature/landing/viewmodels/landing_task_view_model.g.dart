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
    extends $NotifierProvider<LandingTaskViewModel, AsyncValue<TaskModel>?> {
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
  Override overrideWithValue(AsyncValue<TaskModel>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<TaskModel>?>(value),
    );
  }
}

String _$landingTaskViewModelHash() =>
    r'74518f50f30b9bdc9c868b97d178ef6dbd41f9f1';

abstract class _$LandingTaskViewModel
    extends $Notifier<AsyncValue<TaskModel>?> {
  AsyncValue<TaskModel>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<TaskModel>?, AsyncValue<TaskModel>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TaskModel>?, AsyncValue<TaskModel>?>,
              AsyncValue<TaskModel>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
