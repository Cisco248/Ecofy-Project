class AuthSignUpSchema {
  String? userId;
  String userFirstName;
  String userLastName;
  String userEmail;
  String userPassword;
  String userConfirmPassword;
  double userMobileNum;

  AuthSignUpSchema({
    this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.userPassword,
    required this.userConfirmPassword,
    required this.userMobileNum,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userFirstName': userFirstName,
    'userLastName': userLastName,
    'userEmail': userEmail,
    'userPassword': userPassword,
    'userConfirmPassword': userConfirmPassword,
    'userMobileNum': userMobileNum,
  };
}

class AuthSignInModel {
  String userEmail;
  String userPassword;

  AuthSignInModel({required this.userEmail, required this.userPassword});

  Map<String, dynamic> toJson() => {
    'email': userEmail,
    'password': userPassword,
  };
}
