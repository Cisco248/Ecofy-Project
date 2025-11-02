import 'dart:ui';
import 'package:e_wms_mobile/utilities/database/translate_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localization/flutter_localization.dart';

class TranslateProvider extends ChangeNotifier {
  final FlutterLocalization localization = FlutterLocalization.instance;
  final translateDB = TranslateDatabase();

  void configLocalization() {
    localization.init(mapLocales: translateDB.locales, initLanguageCode: 'en');
    localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  void _onTranslatedLanguage(Locale? locale) {
    notifyListeners();
  }

  void changeLanguage(String code) {
    localization.translate(code);
  }
}
