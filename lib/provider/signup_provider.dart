import 'package:e_wms_mobile/database/auth_database.dart';
import 'package:e_wms_mobile/model/auth_model.dart';
import 'package:e_wms_mobile/utilities/constants/text.dart';
import 'package:e_wms_mobile/utilities/helpers/exception_helper.dart';
import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  AuthDatabase auth = AuthDatabase();

  final List<AuthModel> _user = [];

  List<AuthModel> get user => _user;

  bool emailExists(String email) => auth.userEmail == email;

  Future<void> createUser(
    String firstName,
    String lastName,
    String email,
    String password,
    double mobileNum,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      if (emailExists(email)) {
        throw AuthException(emailExistsText);
      } else {
        final newUser = AuthModel(
          userId: DateTime.now().toString(),
          userFirstName: firstName,
          userLastName: lastName,
          userEmail: email,
          userPassword: password,
          userMobileNum: mobileNum,
        );
        _user.insert(0, newUser);
        notifyListeners();
      }
    } catch (e) {
      throw AuthException(loginError);
    }
  }

  String? fname;
  String? lname;
  String? email;
  String? password;
  String? confirmPassword;

  int currentStep = 0;

  void setName(String val1, String val2) {
    fname = val1;
    lname = val2;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String v1, String v2) {
    password = v1;
    confirmPassword = v2;
    notifyListeners();
  }

  void setStep(int step) {
    currentStep = step;
    notifyListeners();
  }
}
