import 'package:e_wms_mobile/model/goal_model.dart';
import 'package:flutter/material.dart';

class GoalProvider extends ChangeNotifier {
  final List<Goal> _goals = [
    Goal(
      title: 'Gather Wastes',
      description: 'Build your first Flutter app in 30 days',
      image: 'lib/assets/images/ravi.jpg',
    ),
    Goal(
      title: 'Workout',
      description: 'Exercise 5 times per week',
      image: 'lib/assets/images/ravi.jpg',
    ),
  ];

  List<Goal> get goalsList => _goals;

  void addGoal(Goal goal) {
    _goals.add(goal);
    notifyListeners();
  }

  void removeGoal(int index) {
    _goals.removeAt(index);
    notifyListeners();
  }
}
