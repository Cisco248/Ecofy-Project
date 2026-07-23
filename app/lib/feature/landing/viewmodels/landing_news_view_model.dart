// ignore_for_file: only_use_keep_alive_inside_keep_alive
import 'package:fpdart/fpdart.dart';
import 'package:wms_app/utilities/helpers/app_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/feature/landing/models/news_model.dart';
import 'package:wms_app/feature/landing/repository/landing_repository.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';

part 'landing_news_view_model.g.dart';

@Riverpod(keepAlive: true)
class LandingNewsViewModel extends _$LandingNewsViewModel {
  late LandingRepository _landingRepository;
  @override
  AsyncValue<List<NewsModel>>? build() {
    _landingRepository = ref.watch(landingRepositoryProvider);
    return null;
  }

  Future<List<NewsModel>?> getNewsData() async {
    try {
      state = AsyncValue.loading();

      final newsRes = await _landingRepository.getDailyNews();

      final val = switch (newsRes) {
        Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
        Right(value: final r) => state = AsyncValue.data(r),
      };
      DebugPrint(val, '[NEWS] ViewModel Status').log();
      return val.value;
    } catch (e) {
      Left(AppFailure('Error: $e'));
    }
    return null;
  }
}
