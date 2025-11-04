import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_wms_mobile/main_layout.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:e_wms_mobile/data/utilities/themes/theme.dart';
import 'package:e_wms_mobile/core/provider/profile_provider.dart';
import 'package:e_wms_mobile/core/provider/translate_provider.dart';
import 'package:e_wms_mobile/presentation/pages/login_page.dart';
import 'package:e_wms_mobile/presentation/pages/signup_page.dart';
import 'package:e_wms_mobile/core/provider/announce_provider.dart';
import 'package:e_wms_mobile/core/provider/appbar_provider.dart';
import 'package:e_wms_mobile/core/provider/goal_provider.dart';
import 'package:e_wms_mobile/core/provider/locate_provider.dart';
import 'package:e_wms_mobile/core/provider/news_provider.dart';
import 'package:e_wms_mobile/core/provider/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AppBarProvider()),
        ChangeNotifierProvider(create: (_) => GoalProvider()),
        ChangeNotifierProvider(create: (_) => AnnounceProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => LocateProvider()),
        ChangeNotifierProvider(create: (_) => TranslateProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  late final provider = Provider.of<TranslateProvider>(context, listen: false);

  @override
  void initState() {
    provider.configLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Waste Management System',
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      home: LoginPage(),
      routes: {
        '/home': (context) => MainWrapper(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
