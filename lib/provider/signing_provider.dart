import 'package:e_wms_mobile/database/auth_database.dart';
import 'package:flutter/widgets.dart';

class SignInProvider extends ChangeNotifier {
  AuthDatabase auth = AuthDatabase();

  bool login(String email, String password) {
    return auth.userEmail == email && auth.userPassword == password;
  }

  bool logOut(String email) => auth.userEmail != email ? true : false;
}
