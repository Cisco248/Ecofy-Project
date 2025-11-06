import 'dart:convert';

class UserSignInModels {
  String userId;
  String userEmail;
  String userPassword;

  UserSignInModels({
    required this.userId,
    required this.userEmail,
    required this.userPassword,
  });

  UserSignInModels copyWith({
    String? userId,
    String? userEmail,
    String? userPassword,
  }) {
    return UserSignInModels(
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      userPassword: userPassword ?? this.userPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': userId,
      'email': userEmail,
      'password': userPassword,
    };
  }

  factory UserSignInModels.fromMap(Map<String, dynamic> map) {
    return UserSignInModels(
      userId: map['id'] ?? '',
      userEmail: map['email'] ?? '',
      userPassword: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSignInModels.fromJson(String source) =>
      UserSignInModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserSignInModels(userId: $userId, userEmail: $userEmail, userPassword: $userPassword)';

  @override
  bool operator ==(covariant UserSignInModels other) {
    if (identical(this, other)) return true;
    return other.userEmail == userEmail &&
        other.userId == userId &&
        other.userPassword == userPassword;
  }

  @override
  int get hashCode =>
      userEmail.hashCode ^ userId.hashCode ^ userPassword.hashCode;
}
