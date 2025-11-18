import 'package:flutter/material.dart';
import 'package:wms_app/core/providers/current_user_notifier.dart';
import 'package:wms_app/feature/auth/views/sign_in_page.dart';
import 'package:wms_app/main_layout.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';
import 'package:wms_app/utilities/themes/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_app/feature/auth/viewmodels/auth_view_model.dart';
import 'package:wms_app/feature/profile/viewmodels/profile_view_model.dart';
import 'package:wms_app/feature/landing/viewmodels/landing_news_view_model.dart';
import 'package:wms_app/feature/landing/viewmodels/landing_task_view_model.dart';
import 'package:wms_app/feature/landing/viewmodels/landing_announce_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // get the access for the ref.read method using the ProviderContainer()
  final container = ProviderContainer();
  final authContainer = container.read(authViewModelProvider.notifier);
  await authContainer.initSharedPreferences();

  final profileContainer = container.read(profileViewModelProvider.notifier);
  await profileContainer.initSharedPreferences();
  await profileContainer.getUserDate();

  final landingTaskContainer = container.read(
    landingTaskViewModelProvider.notifier,
  );
  await landingTaskContainer.getTaskData();

  final landingNewsContainer = container.read(
    landingNewsViewModelProvider.notifier,
  );
  await landingNewsContainer.getNewsData();

  final landingAnnounceContainer = container.read(
    landingAnnounceViewModelProvider.notifier,
  );
  await landingAnnounceContainer.getAnnounceData();

  // After set the container into the UncontrolledProviderScope() instance
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    // Custom Debug logger
    DebugPrint(currentUser, "Current User State").log();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WMS_Application',
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: currentUser == null ? const LoginPage() : const MainWrapper(),
    );
  }
}
