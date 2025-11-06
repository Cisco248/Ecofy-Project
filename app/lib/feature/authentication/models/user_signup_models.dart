// Create a UserModels class to represent user data to repository
import 'dart:convert';

class UserSignUpModels {
  final String userId;
  final String userFirstName;
  final String userLastName;
  final String userEmail;
  final String userPassword;
  final String userConfirmPassword;
  final String userMobileNum;

  UserSignUpModels({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.userPassword,
    required this.userConfirmPassword,
    required this.userMobileNum,
  });

  UserSignUpModels copyWith({
    String? userId,
    String? userFirstName,
    String? userLastName,
    String? userEmail,
    String? userPassword,
    String? userConfirmPassword,
    String? userMobileNum,
  }) {
    return UserSignUpModels(
      userId: userId ?? this.userId,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userEmail: userEmail ?? this.userEmail,
      userPassword: userPassword ?? this.userPassword,
      userConfirmPassword: userConfirmPassword ?? this.userConfirmPassword,
      userMobileNum: userMobileNum ?? this.userMobileNum,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': userId,
      'fname': userFirstName,
      'lname': userLastName,
      'email': userEmail,
      'password': userPassword,
      'conpassword': userConfirmPassword,
      'mobnum': userMobileNum,
    };
  }

  factory UserSignUpModels.fromMap(Map<String, dynamic> map) {
    return UserSignUpModels(
      userId: map['id'] ?? '',
      userFirstName: map['fname'] ?? '',
      userLastName: map['lname'] ?? '',
      userEmail: map['email'] ?? '',
      userPassword: map['password'] ?? '',
      userConfirmPassword: map['conpassword'] ?? '',
      userMobileNum: map['mobnum'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSignUpModels.fromJson(String source) =>
      UserSignUpModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserSignUpModels(userId: $userId, userFirstName: $userFirstName, userLastName: $userLastName, userEmail: $userEmail, userPassword: $userPassword, userConfirmPassword: $userConfirmPassword, userMobileNum: $userMobileNum)';

  @override
  bool operator ==(covariant UserSignUpModels other) {
    if (identical(this, other)) return true;
    return other.userId == userId &&
        other.userEmail == userEmail &&
        other.userPassword == userPassword &&
        other.userFirstName == userFirstName &&
        other.userLastName == userLastName &&
        other.userConfirmPassword == userConfirmPassword &&
        other.userMobileNum == userMobileNum;
  }

  @override
  int get hashCode =>
      userId.hashCode ^
      userFirstName.hashCode ^
      userLastName.hashCode ^
      userEmail.hashCode ^
      userPassword.hashCode ^
      userConfirmPassword.hashCode ^
      userMobileNum.hashCode;
}
