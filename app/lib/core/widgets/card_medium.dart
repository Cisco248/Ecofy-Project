import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/color.dart';

enum Priority {
  high,
  medium,
  low;

  Color get color {
    switch (this) {
      case Priority.high:
        return Colors.red.shade300;
      case Priority.medium:
        return Colors.orange.shade300;
      case Priority.low:
        return Colors.green.shade300;
    }
  }
}

class CardMedium extends StatelessWidget {
  final String title;
  final String description;
  final String dueDate;
  final ImageProvider? img;
  final Widget? child;
  final String priority;

  const CardMedium({
    super.key,
    this.img,
    required this.title,
    required this.description,
    required this.dueDate,
    this.child,
    required this.priority,
  });

  Color getPriorityColor(String p) {
    final priority = Priority.values.firstWhere(
      (e) => e.name == p.toLowerCase(),
      orElse: () => Priority.low,
    );
    return priority.color;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(12),
          border: BoxBorder.all(color: AppColors.borderLight),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Due Date: $dueDate',
                    style: TextStyle(fontSize: 11, color: Colors.blue),
                  ),
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: getPriorityColor(priority),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
