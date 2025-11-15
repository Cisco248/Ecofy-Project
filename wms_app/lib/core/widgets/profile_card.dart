// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/color.dart';

Widget TextCard(
  BuildContext context,
  IconData icon,
  String label,
  String value,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.borderLight),
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.antiAlias,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 24, color: AppColors.primaryDark),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value.isNotEmpty ? value : 'Not provided',
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ), // Add this
      ],
    ),
  );
}

Widget AvatarCard(
  BuildContext context,
  String letter,
  String image, {
  bool? isIMG = false,
}) {
  return isIMG == true
      ? Image.asset(image)
      : Center(
          child: CircleAvatar(
            radius: 100,
            backgroundColor: AppColors.primaryDark,
            child: Text(
              letter[0],
              style: const TextStyle(fontSize: 70, color: Colors.white),
            ),
          ),
        );
}
