import 'package:e_wms_mobile/data/utilities/database/auth_database.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  AuthDatabase auth = AuthDatabase();

  String get userName => auth.userFirstName + auth.userLastName;
  String get userEmail => auth.userEmail;
  String get userId => auth.userId;
  double get userNum => auth.userMobileNum;
}
