// ignore_for_file: only_use_keep_alive_inside_keep_alive
import 'package:fpdart/fpdart.dart';
import 'package:wms_app/utilities/helpers/app_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/feature/landing/models/announce_model.dart';
import 'package:wms_app/feature/landing/repository/landing_repository.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';

part 'landing_announce_view_model.g.dart';

@Riverpod(keepAlive: true)
class LandingAnnounceViewModel extends _$LandingAnnounceViewModel {
  late LandingRepository _landingRepository;

  @override
  AsyncValue<List<AnnounceModel>>? build() {
    _landingRepository = ref.watch(landingRepositoryProvider);
    return null;
  }

  Future<List<AnnounceModel>?> getAnnounceData() async {
    try {
      state = AsyncValue.loading();

      final newsRes = await _landingRepository.getWeeklyAnnouncements();

      final val = switch (newsRes) {
        Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
        Right(value: final r) => state = AsyncValue.data(r),
      };
      DebugPrint(val, '[ANNOUNCEMENT] ViewModel Status').log();
      return val.value;
    } catch (e) {
      Left(AppFailure('Error: $e'));
    }
    return null;
  }
}
