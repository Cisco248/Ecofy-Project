class AuthModel {
  final String userId;
  final String userFirstName;
  final String userLastName;
  final String userEmail;
  final String userPassword;
  final double userMobileNum;

  AuthModel({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.userPassword,
    required this.userMobileNum,
  });
}
