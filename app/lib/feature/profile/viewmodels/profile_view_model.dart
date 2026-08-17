// ignore_for_file: only_use_keep_alive_inside_keep_alive
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/core/providers/current_profile_notifier.dart';
import 'package:wms_app/feature/auth/repository/auth_local_repository.dart';
import 'package:wms_app/feature/profile/models/profile_model.dart';
import 'package:wms_app/feature/profile/repository/profile_remote_repository.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';

part 'profile_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProfileViewModel extends _$ProfileViewModel {
  late ProfileRemoteRepository _profileRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentProfileNotifier _currentProfileNotifier;

  @override
  AsyncValue<ProfileModel>? build() {
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _profileRemoteRepository = ref.watch(profileRemoteRepositoryProvider);
    _currentProfileNotifier = ref.watch(currentProfileProvider.notifier);

    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  AsyncValue<ProfileModel> _getSuccess(ProfileModel user) {
    _currentProfileNotifier.addProfile(user);
    return state = AsyncValue.data(user);
  }

  Future<ProfileModel?> getUserDate() async {
    try {
      state = AsyncValue.loading();

      final token = _authLocalRepository.getToken();

      if (token != null) {
        final res = await _profileRemoteRepository.getUserData(token);

        final val = switch (res) {
          Left(value: final l) => state = AsyncValue.error(
            l.message,
            StackTrace.current,
          ),
          Right(value: final r) => _getSuccess(r),
        };
        DebugPrint(val, "[PROFILE] ViewModel Status").log();
        return val.value;
      }
    } catch (e) {
      Exception('Error: $e');
    }
    return null;
  }
}
