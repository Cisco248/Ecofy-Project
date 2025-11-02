import 'package:e_wms_mobile/utilities/database/news_database.dart';
import 'package:e_wms_mobile/model/news_model.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
final _news = NewsDatabase.news;

  List<NewsModel> get newsList => _news;

  void addNews(NewsModel n) {
    _news.add(n);
    notifyListeners();
  }

  void removeNews(int index) {
    _news.removeAt(index);
    notifyListeners();
  }
}
