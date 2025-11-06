import 'package:e_wms_mobile/main_layout.dart';
import 'package:e_wms_mobile/feature/authentication/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:e_wms_mobile/utilities/themes/theme.dart';
import 'package:e_wms_mobile/feature/authentication/pages/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:e_wms_mobile/presentation/pages/signup_page.dart';
// import 'package:e_wms_mobile/main_layout.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Waste Management System',
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: LoginPage(),
      routes: {
        '/home': (context) => const MainWrapper(),
        '/signup': (context) => const SignupPage(),
      },
    );
  }
}
