import 'package:e_wms_mobile/main_layout.dart';
import 'package:e_wms_mobile/provider/announce_provider.dart';
import 'package:e_wms_mobile/provider/appbar_provider.dart';
import 'package:e_wms_mobile/provider/goal_provider.dart';
import 'package:e_wms_mobile/provider/signing_provider.dart';
import 'package:e_wms_mobile/provider/signup_provider.dart';
// import 'package:e_wms_mobile/screen/pages/login_page.dart';
import 'package:e_wms_mobile/screen/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:e_wms_mobile/themes/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => AppBarProvider()),
        ChangeNotifierProvider(create: (_) => GoalProvider()),
        ChangeNotifierProvider(create: (_) => AnnounceProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Waste Management System',
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      home: MainWrapper(),
      // LoginPage(),
      routes: {
        '/home': (context) => MainWrapper(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
