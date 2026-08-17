import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/color.dart';

enum NotificationType { success, error, warning, info }

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  void show({
    required BuildContext context,
    required String message,
    required NotificationType type,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.txtWhite),
        ),
        backgroundColor: _getColorForType(type),
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Convenience methods
  void showSuccess(BuildContext context, String message) {
    show(context: context, message: message, type: NotificationType.success);
  }

  void showError(BuildContext context, String message) {
    show(context: context, message: message, type: NotificationType.error);
  }

  void showWarning(BuildContext context, String message) {
    show(context: context, message: message, type: NotificationType.warning);
  }

  void showInfo(BuildContext context, String message) {
    show(context: context, message: message, type: NotificationType.info);
  }

  Color _getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return AppColors.snackBarSuccess;
      case NotificationType.error:
        return AppColors.snackBarError;
      case NotificationType.warning:
        return AppColors.snackBarWarning;
      case NotificationType.info:
        return AppColors.snackBarInfo;
    }
  }
}
