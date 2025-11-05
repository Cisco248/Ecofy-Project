import 'package:e_wms_mobile/main_layout.dart';
import 'package:e_wms_mobile/feature/authentication/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:e_wms_mobile/utilities/themes/theme.dart';
import 'package:e_wms_mobile/feature/authentication/pages/login_page.dart';
// import 'package:e_wms_mobile/presentation/pages/signup_page.dart';
// import 'package:e_wms_mobile/main_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
