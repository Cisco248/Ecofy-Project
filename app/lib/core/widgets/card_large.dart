import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/color.dart';

class CardLarge extends StatelessWidget {
  final String title;
  final String description;
  final String dueDate;

  const CardLarge({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderLight),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(description, style: TextStyle(fontSize: 13)),
              SizedBox(height: 4),
              Text(
                "Due Date: $dueDate",
                style: TextStyle(color: Colors.blueAccent, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
