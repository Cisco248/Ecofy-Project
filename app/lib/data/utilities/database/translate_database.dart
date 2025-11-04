import 'package:e_wms_mobile/data/model/text_data.dart';
import 'package:flutter_localization/flutter_localization.dart';

class TranslateDatabase implements TextData {
  static const title = TextData.title;
  static const body = TextData.body;

  static const Map<String, dynamic> en = {
    title: 'Hello, User',
    body: 'Here English',
  };

  static final Map<String, dynamic> si = {
    title: 'හෙලෝ, පරිශීලකයා',
    body: 'මෙන්න සිංහල',
  };

  static final Map<String, dynamic> ta = {
    title: 'வணக்கம், பயனர்',
    body: 'இதோ தமிழ்',
  };

  final List<MapLocale> locales = [
    MapLocale('en', TranslateDatabase.en),
    MapLocale('si', TranslateDatabase.si),
    MapLocale('ta', TranslateDatabase.ta),
  ];
}
