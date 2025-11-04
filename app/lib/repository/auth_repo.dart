import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<void> signIn({required String email, required String password}) async {
    await http.post(
      Uri.parse('http://10.0.2.2:8000/auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  Future<void> signUp({
    required String fname,
    required String lname,
    required String email,
    required String password,
    required String confirmpassword,
    required String mobilenum,
  }) async {
    await http.post(
      Uri.parse('http://10.0.2.2:8000/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': fname,
        'last_name': lname,
        'email': email,
        'password': password,
        'confirm_password': confirmpassword,
        'mobile_number': mobilenum,
      }),
    );
  }
}

Future<void> signOut(BuildContext context) {
  Future.delayed(Duration(seconds: 1));
  return Navigator.of(context).pushReplacementNamed('/login');
}
