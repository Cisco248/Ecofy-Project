class Validator {
  String? validateRequirement(String? value) {
    if (value == '') {
      return 'Field cannot be empty';
    } else {
      return null;
    }
  }

  String? validateEmail(String email) {
    if (email == '' || email.trim().isEmpty) {
      return "Field cannot be empty";
    } else {
      if (!email.contains('@')) {
        return "Enter a valid email address";
      }
      return null;
    }
  }

  String? validatePassword(String pwd) {
    if (pwd == '' || pwd.trim().isEmpty) {
      return "Field cannot be empty";
    } else {
      if (pwd.length < 8) {
        return "Password must be at least 8 characters long";
      } else {
        final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)\$');
        if (passwordRegex.hasMatch(pwd)) {
          return "Password must contain uppercase, lowercase, and a number";
        } 
      }
    }
    return null;
  }
}
