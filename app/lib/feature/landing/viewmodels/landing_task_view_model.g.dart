// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landing_task_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LandingTaskViewModel)
final landingTaskViewModelProvider = LandingTaskViewModelProvider._();

final class LandingTaskViewModelProvider
    extends
        $NotifierProvider<LandingTaskViewModel, AsyncValue<List<TaskModel>>?> {
  LandingTaskViewModelProvider._()
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
    r'd13584c64424fd23214837766d552e4f2db03875';

abstract class _$LandingTaskViewModel
    extends $Notifier<AsyncValue<List<TaskModel>>?> {
  AsyncValue<List<TaskModel>>? build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
