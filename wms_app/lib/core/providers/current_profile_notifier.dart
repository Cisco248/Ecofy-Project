import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/feature/profile/models/profile_model.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';

part 'current_profile_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentProfileNotifier extends _$CurrentProfileNotifier {
  @override
  ProfileModel? build() {
    return null;
  }

  void addProfile(ProfileModel profile) => state = profile;

  void logOut() {
    state = null;
    DebugPrint(state, '[LOGOUT] Status').log();
  }
}
