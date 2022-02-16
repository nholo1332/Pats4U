import 'package:pats4u/models/lunch_menu_item.dart';

class WeekMenu {
  // Create model variables
  List<LunchMenuItem> breakfast = [];
  List<LunchMenuItem> lunch = [];

  WeekMenu();

  // Convert JSON to data model variables
  WeekMenu.fromJson(Map<String, dynamic> json) {
    breakfast = ((json['breakfast'] ?? []) as List)
        .map((m) => LunchMenuItem.fromJson(m))
        .toList();
    lunch = ((json['lunch'] ?? []) as List)
        .map((m) => LunchMenuItem.fromJson(m))
        .toList();
  }
}
