import 'package:pats4u/models/lunch_menu_item.dart';

class WeekMenu {
  List<LunchMenuItem> breakfast = [];
  List<LunchMenuItem> lunch = [];

  WeekMenu();

  WeekMenu.fromJson(Map<String, dynamic> json) {
    breakfast = ((json['breakfast'] ?? []) as List)
        .map((m) => LunchMenuItem.fromJson(m))
        .toList();
    lunch = ((json['lunch'] ?? []) as List)
        .map((m) => LunchMenuItem.fromJson(m))
        .toList();
  }
}
