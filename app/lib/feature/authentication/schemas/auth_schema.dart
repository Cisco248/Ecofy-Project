class AuthSignUpSchema {
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String conpassword;
  final String mobnum;

  AuthSignUpSchema({
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    required this.conpassword,
    required this.mobnum,
  });

  Map<String, dynamic> toJson() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
      'password': password,
      'conpassword': conpassword,
      'mobnum': mobnum,
    };
  }

  factory AuthSignUpSchema.fromJson(Map<String, dynamic> json) {
    return AuthSignUpSchema(
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      conpassword: json['conpassword'] as String,
      mobnum: json['mobnum'] as String,
    );
  }

  // Helper constructor to create from your UI field names
  factory AuthSignUpSchema.fromUserInput({
    required String userFirstName,
    required String userLastName,
    required String userEmail,
    required String userPassword,
    required String userConfirmPassword,
    required String userMobileNum,
  }) {
    return AuthSignUpSchema(
      fname: userFirstName,
      lname: userLastName,
      email: userEmail,
      password: userPassword,
      conpassword: userConfirmPassword,
      mobnum: userMobileNum,
    );
  }
}

class AuthSignInSchema {
  String userEmail;
  String userPassword;

  AuthSignInSchema({required this.userEmail, required this.userPassword});

  Map<String, dynamic> toJson() => {
    'email': userEmail,
    'password': userPassword,
  };
}
