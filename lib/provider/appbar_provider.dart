import 'package:e_wms_mobile/database/auth_database.dart';
import 'package:flutter/material.dart';

class AppBarProvider extends ChangeNotifier {
  String greeting = '';
  String username = '';
  double currentToken = 0;

  final AuthDatabase _auth = AuthDatabase();

  var time = DateTime.now().hour;

  String setGreeting() {
    if(time >= 5 && time <= 12) {
      greeting = 'Good Morning, ';
      return greeting;
    }
    else if(time >= 12 && time <= 17) {
      greeting = 'Good Afternoon,';
      return greeting;
    }
    else if(time >= 17 && time <= 21) {
      greeting = 'Good Evening,';
      return greeting;
    }
    else {
      greeting = 'Good Night,';
      return greeting;
    }
  }

  String setUsername() {
    username = '${_auth.userFirstName} ${_auth.userLastName}';
    return username;
  }

  void setToken(double tokenVal) {
    currentToken = tokenVal;
    notifyListeners();
  }
}
