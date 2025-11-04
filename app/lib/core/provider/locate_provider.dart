import 'package:flutter/material.dart';

class LocateProvider extends ChangeNotifier {
  String _distance = '0';
  String _status = '';

  String get distance => _distance;
  String get status => _status;

  void setDistance(String d) {
    _distance = d;
    notifyListeners();
  }

  void setStatus(String st) {
    _status = st;
    notifyListeners();
  }

  String? changeDistance(String? value) => value ?? '0';

  String? changeStatus(String? status) => status ?? 'Unknown';
}
