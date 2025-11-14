import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/feature/landing/models/announce_model.dart';
import 'package:wms_app/feature/landing/repository/landing_repository.dart';
import 'package:wms_app/utilities/helpers/app_failure.dart';

part 'landing_announce_view_model.g.dart';

@Riverpod(keepAlive: true)
class LandingAnnounceViewModel extends _$LandingAnnounceViewModel {
  late LandingRepository _landingRepository;

  @override
  AsyncValue<AnnounceModel>? build() {
    // ignore: only_use_keep_alive_inside_keep_alive
    _landingRepository = ref.watch(landingRepositoryProvider);
    return null;
  }

  Future<AnnounceModel?> getNewsData() async {
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

      return val.value;
    } catch (e) {
      Left(AppFailure('Error: $e'));
    }
    return null;
  }
}
