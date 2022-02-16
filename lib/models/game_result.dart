import 'package:pats4u/models/event_types.dart';
import 'package:pats4u/models/team.dart';

class GameResult {
  // Create model variables
  Team home = Team();
  Team guest = Team();
  bool finalResult = true;
  EventTypes sport = EventTypes.football;
  DateTime date = DateTime.now();

  GameResult();

  // Convert JSON to data model variables
  GameResult.fromJson(Map<String, dynamic> json) {
    home = Team.fromJson(json['home'] ?? []);
    guest = Team.fromJson(json['guest'] ?? []);
    finalResult = json['finalResult'] ?? true;
    sport = json['sport'] != null
        ? EventTypes.values.firstWhere((m) => m.name == json['sport'],
        orElse: () => EventTypes.school)
        : EventTypes.school;
    date = json['date'] != null
        ? DateTime.parse(json['date']).toLocal()
        : DateTime.now();
  }
}
