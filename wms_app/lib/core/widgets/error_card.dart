// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/color.dart';

Widget ErrorCard(BuildContext context, String error, String imageError) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 32),
          const SizedBox(height: 16),
          Text(imageError, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(color: AppColors.error),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
