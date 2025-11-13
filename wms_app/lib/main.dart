import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_app/feature/auth/viewmodels/auth_view_model.dart';
import 'package:wms_app/feature/auth/views/sign_in_page.dart';
import 'package:wms_app/feature/profile/viewmodels/profile_view_model.dart';
// import 'package:wms_app/feature/auth/views/sign_up_page.dart';
import 'package:wms_app/utilities/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // get the access for the ref.read methed using the ProviderContainer()
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container
      .read(profileViewModelProvider.notifier)
      .initSharedPreferences();
  final profileContainer = container.read(profileViewModelProvider.notifier);
  await profileContainer.getUserDate();
  // After set the container into the UncontrolledProviderScope() instance
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: LoginPage(),
    );
  }
}
