import 'dart:convert';

/// A model class representing the profile information of a user.
///
/// This class is used to encapsulate the data related to a user's profile,
/// which may include attributes such as name, email, and other relevant details.
class ProfileModel {
  final String token;
  final String fname;
  final String lname;
  final String email;
  final String mobnum;
  final String password;

  ProfileModel({
    required this.token,
    required this.fname,
    required this.lname,
    required this.email,
    required this.mobnum,
    required this.password,
  });

  ProfileModel copyWith({
    String? token,
    String? fname,
    String? lname,
    String? email,
    String? mobnum,
    String? password,
  }) {
    return ProfileModel(
      token: token ?? this.token,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      mobnum: mobnum ?? this.mobnum,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'fname': fname,
      'lname': lname,
      'email': email,
      'mobnum': mobnum,
      'password': password,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      token: map['token'] ?? '',
      fname: map['fname'] ?? '',
      lname: map['lname'] ?? '',
      email: map['email'] ?? '',
      mobnum: map['mobnum'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileModel(token: $token, fname: $fname, lname: $lname, email: $email, mobnum: $mobnum, password: $password)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.fname == fname &&
        other.lname == lname &&
        other.email == email &&
        other.mobnum == mobnum &&
        other.password == password;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        fname.hashCode ^
        lname.hashCode ^
        email.hashCode ^
        mobnum.hashCode ^
        password.hashCode;
  }
}
