import 'dart:convert';

class UserModel {
  final String token;
  final String id;
  final String fname;
  final String lname;
  final String email;
  final String mobnum;
  final String password;
  final String conpassword;

  UserModel({
    required this.token,
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.mobnum,
    required this.password,
    required this.conpassword,
  });

  UserModel copyWith({
    String? token,
    String? id,
    String? fname,
    String? lname,
    String? email,
    String? mobnum,
    String? password,
    String? conpassword,
  }) {
    return UserModel(
      token: token ?? this.token,
      id: id ?? this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      mobnum: mobnum ?? this.mobnum,
      password: password ?? this.password,
      conpassword: conpassword ?? this.conpassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'id': id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'mobnum': mobnum,
      'password': password,
      'conpassword': conpassword,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      id: json['id'] ?? '',
      fname: json['fname'] ?? '',
      lname: json['lname'] ?? '',
      email: json['email'] ?? '',
      mobnum: json['mobnum'] ?? '',
      password: json['password'] ?? '',
      conpassword: json['conpassword'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(token: $token, id: $id, fname: $fname, lname: $lname, email: $email, mobnum: $mobnum, password: $password, conpassword: $conpassword)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.id == id &&
        other.fname == fname &&
        other.lname == lname &&
        other.email == email &&
        other.mobnum == mobnum &&
        other.password == password &&
        other.conpassword == conpassword;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        id.hashCode ^
        fname.hashCode ^
        lname.hashCode ^
        email.hashCode ^
        mobnum.hashCode ^
        password.hashCode ^
        conpassword.hashCode;
  }
}
