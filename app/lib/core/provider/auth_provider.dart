import 'package:e_wms_mobile/core/constants/text.dart';
import 'package:e_wms_mobile/core/helpers/exception_helper.dart';
import 'package:e_wms_mobile/data/model/auth_model.dart';
import 'package:e_wms_mobile/data/utilities/database/auth_database.dart';
import 'package:flutter/material.dart';

// initialize auth database
AuthDatabase auth = AuthDatabase();

// temporary user data
class TempUser {
  String uFName;
  String uLName;
  String uEmail;
  String uPassword;
  String uCPassword;
  double uMobileNum;

  TempUser({
    required this.uFName,
    required this.uLName,
    required this.uEmail,
    required this.uPassword,
    required this.uCPassword,
    required this.uMobileNum,
  });
}

// user list
final List<AuthModel> _user = [];

// getter for user list
List<AuthModel> get user => _user;

class AuthProvider extends ChangeNotifier {
  String fname = '';
  String lname = '';
  String email = '';
  String password = '';
  String confirmpassword = '';

  // Access the temp user data
  TempUser get tempUser => TempUser(
    uFName: '',
    uLName: '',
    uEmail: '',
    uPassword: '',
    uCPassword: '',
    uMobileNum: 0,
  );

  // check if email already exists
  // bool emailExists(String email) => auth.userEmail == email;

  // check if email already exists
  Future<void> existEmailCheck(String email) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      if (auth.userEmail == email) {
        throw AuthException(emailExistsText);
      } else {
        return;
      }
    } catch (e) {
      throw AuthException(loginError);
    }
  }

  // Create new user
  Future<void> createUser(TempUser user) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      if (existEmailCheck(user.uEmail) != '') {
        throw AuthException(emailExistsText);
      } else {
        final newUser = AuthModel(
          userId: DateTime.now().toString(),
          userFirstName: user.uFName,
          userLastName: user.uLName,
          userEmail: user.uEmail,
          userPassword: user.uPassword,
          userMobileNum: user.uMobileNum,
        );
        _user.insert(0, newUser);
        notifyListeners();
      }
    } catch (e) {
      throw AuthException(loginError);
    }
  }

  // signup form stepper
  int currentStep = 0;

  // // setters for user names
  // void setName(String fname, String lname) {
  //   uFName = fname;
  //   uLName = lname;
  //   notifyListeners();
  // }

  // // setter for user emails
  // void setEmail(String email) {
  //   uEmail = email;
  //   notifyListeners();
  // }

  // // setter for user passwords
  // void setPassword(String password, String cPassword) {
  //   uPassword = password;
  //   uCPassword = cPassword;
  //   notifyListeners();
  // }

  // setter for current steps
  void setStep(int step) {
    currentStep = step;
    notifyListeners();
  }

  // User login method
  bool login(String email, String password) {
    return auth.userEmail == email && auth.userPassword == password;
  }

  // Future<bool> loginAsync(String email, String password) async {
  //   try {
  //     await Future.delayed(const Duration(milliseconds: 500));
  //     if (auth.userEmail == email && auth.userPassword == password) {
  //       return true;
  //     } else {
  //       throw AuthException(loginError);
  //     }
  //   } catch (e) {
  //     throw AuthException(loginError);
  //   }
  // }

  // User logout method
  bool logOut(String email) => auth.userEmail != email ? true : false;
}
