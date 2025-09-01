import 'package:e_wms_mobile/database/goal_database.dart';
import 'package:e_wms_mobile/model/goal_model.dart';
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
