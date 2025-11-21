import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/feature/discover/models/discover_model.dart';
import 'package:wms_app/feature/discover/repository/discover_repository.dart';
import 'package:wms_app/utilities/helpers/app_failure.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';

part 'discover_view_model.g.dart';

@Riverpod(keepAlive: true)
class DiscoverViewModel extends _$DiscoverViewModel {
  late DiscoverRepository _discoverRepository;

  @override
  AsyncValue<List<DiscoverModel>>? build() {
    _discoverRepository = ref.watch(discoverRepositoryProvider);
    return null;
  }

  Future<List<DiscoverModel>?> getLocation() async {
    try {
      state = AsyncValue.loading();

      final binRes = await _discoverRepository.getBinLoc();

      final val = switch (binRes) {
        Left(value: final l) => state = AsyncValue.error(
          l.message,
          StackTrace.current,
        ),
        Right(value: final r) => state = AsyncValue.data(r),
      };

      DebugPrint(val, '[DISCOVER] View Model Status').log();
      return val.value;
    } catch (e) {
      Left(AppFailure('Error: $e'));
    }
    return null;
  }
}
