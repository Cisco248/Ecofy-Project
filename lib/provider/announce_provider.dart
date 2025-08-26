import 'package:e_wms_mobile/model/announce_model.dart';
import 'package:flutter/material.dart';

class AnnounceProvider extends ChangeNotifier {
  final List<AnnouncementModel> _announcement = [
    AnnouncementModel(
      title: 'Gather Wastes',
      description: 'Build your first Flutter app in 30 days',
      image: 'lib/assets/images/ravi.jpg',
    ),
    AnnouncementModel(
      title: 'Workout',
      description: 'Exercise 5 times per week',
      image: 'lib/assets/images/ravi.jpg',
    ),
  ];

  List<AnnouncementModel> get announcementList => _announcement;

  void addGoal(AnnouncementModel a) {
    _announcement.add(a);
    notifyListeners();
  }

  void removeGoal(int index) {
    _announcement.removeAt(index);
    notifyListeners();
  }
}
