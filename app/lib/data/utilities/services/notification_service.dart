import 'package:e_wms_mobile/core/constants/color.dart';
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

  void signInNotificationSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$message',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: AppColors.snackBarSuccess,
      ),
    );
  }

  void signInNotificationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$message',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: AppColors.snackBarError,
      ),
    );
  }

  void signUpNotificationSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$message',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: AppColors.snackBarError,
      ),
    );
  }

  void signUpNotificationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$message',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: AppColors.snackBarError,
      ),
    );
  }
}
