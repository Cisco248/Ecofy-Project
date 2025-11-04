import 'package:e_wms_mobile/data/model/goal_model.dart';
import 'package:e_wms_mobile/data/utilities/database/goal_database.dart';
import 'package:flutter/material.dart';

class GoalProvider extends ChangeNotifier {
  final _goals = GoalDatabase.goals;

  List<Goal> get goalsList => _goals;

  void addGoal(Goal g) {
    _goals.add(g);
    notifyListeners();
  }

  void removeGoal(int index) {
    _goals.removeAt(index);
    notifyListeners();
  }
}
