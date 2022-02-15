import 'package:pats4u/models/event_link.dart';
import 'package:pats4u/models/event_types.dart';

class Event {
  String id = '';
  String title = '';
  String description = '';
  String location = '';
  String mapsLink = '';
  EventTypes eventType = EventTypes.school;
  DateTime dateTime = DateTime.now();
  bool allDay = false;
  List<EventLink> links = [];
  bool isUserEvent = false;

  Event();

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['name'] ?? '';
    description = json['description'] ?? '';
    location = json['location'] ?? '';
    mapsLink = json['mapsLink'] ?? '';
    eventType = json['eventType'] != null
        ? EventTypes.values.firstWhere((m) => m.name == json['eventType'],
            orElse: () => EventTypes.school)
        : EventTypes.school;
    dateTime = json['dateTime'] != null
        ? DateTime.parse(json['dateTime']).toLocal()
        : DateTime.now();
    allDay = json['allDay'] ?? false;
    links = ((json['links'] ?? []) as List)
        .map((l) => EventLink.fromJson(l))
        .toList();
    isUserEvent = json['isUserEvent'] ?? false;
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': title,
      'description': description,
      'location': location,
      'eventType': eventType.name,
      'dateTime': dateTime.toUtc().toIso8601String(),
      'allDay': allDay,
      'links': links.map((l) => l.toJSON()).toList(),
      'isUserEvent': isUserEvent,
    };
  }
}
