import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/feature/landing/models/task_model.dart';
import 'package:wms_app/feature/landing/repository/landing_repository.dart';

part 'landing_task_view_model.g.dart';

@Riverpod(keepAlive: true)
class LandingTaskViewModel extends _$LandingTaskViewModel {
  late LandingRepository _landingRepository;

  @override
  AsyncValue<TaskModel>? build() {
    // ignore: only_use_keep_alive_inside_keep_alive
    _landingRepository = ref.watch(landingRepositoryProvider);
    return null;
  }

  Future<TaskModel?> getTaskData() async {
    try {
      state = AsyncValue.loading();

      final getTaskList = await _landingRepository.getDailyTasks();

      final val = switch (getTaskList) {
        Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
        Right(value: final r) => state = AsyncValue.data(r),
      };

      return val.value;
    } catch (e) {
      Exception('Error: $e');
    }
    return null;
  }
}
