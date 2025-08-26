import 'package:flutter/material.dart';

class NotificationService {
  final String? message;
  final String? v1;
  final String? v2;
  final BuildContext context;

  NotificationService({
    required this.message,
    required this.context,
    this.v1,
    this.v2,
  });

  void signInNotification() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$message')));
  }

  void signUpNotification() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$message")));
  }
}
