import 'package:e_wms_mobile/utilities/database/announcement_database.dart';
import 'package:e_wms_mobile/model/announce_model.dart';
import 'package:flutter/material.dart';

class AnnounceProvider extends ChangeNotifier {
final _announcement = AnnouncementDatabase.announcement;

  List<AnnouncementModel> get announcementList => _announcement;

  void addAnnouncement(AnnouncementModel a) {
    _announcement.add(a);
    notifyListeners();
  }

  void removeAnnouncement(int index) {
    _announcement.removeAt(index);
    notifyListeners();
  }
}
