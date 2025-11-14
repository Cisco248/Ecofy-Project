import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/feature/landing/models/news_model.dart';
import 'package:wms_app/feature/landing/repository/landing_repository.dart';
import 'package:wms_app/utilities/helpers/app_failure.dart';

part 'landing_news_view_model.g.dart';

@Riverpod(keepAlive: true)
class LandingNewsViewModel extends _$LandingNewsViewModel {
  late LandingRepository _landingRepository;
  @override
  AsyncValue<NewsModel>? build() {
    // ignore: only_use_keep_alive_inside_keep_alive
    _landingRepository = ref.watch(landingRepositoryProvider);
    return null;
  }

  Future<NewsModel?> getNewsData() async {
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

      return val.value;
    } catch (e) {
      Left(AppFailure('Error: $e'));
    }
    return null;
  }
}
