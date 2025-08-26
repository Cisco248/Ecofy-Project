class Handler {
  final emailController;
  final passwordController;
  final firstNameController;
  final lastNameController;
  final mobileNumController;

  Handler({
    this.emailController,
    this.passwordController,
    this.firstNameController,
    this.lastNameController,
    this.mobileNumController,
  });
}

class LoginHandler extends Handler {
  late final email = emailController();
}
