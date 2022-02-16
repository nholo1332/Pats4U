import 'package:pats4u/models/event_types.dart';

class EventUpdate {
  // Create model variables
  String title = '';
  String content = '';
  EventTypes event = EventTypes.school;
  DateTime date = DateTime.now();

  EventUpdate();

  // Convert JSON to data model variables
  EventUpdate.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    content = json['content'] ?? '';
    event = json['event'] != null
        ? EventTypes.values.firstWhere((m) => m.name == json['event'],
            orElse: () => EventTypes.school)
        : EventTypes.school;
    date = json['date'] != null
        ? DateTime.parse(json['date']).toLocal()
        : DateTime.now();
  }
}
