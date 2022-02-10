import 'package:pats4u/models/event_link.dart';
import 'package:pats4u/models/event_types.dart';
import 'package:pats4u/models/months.dart';

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

  Event();

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    location = json['location'] ?? '';
    mapsLink = json['mapsLink'] ?? '';
    eventType = json['eventType'] != null ? EventTypes.values.firstWhere((m) => m.name == json['eventType'], orElse: () => EventTypes.school) : EventTypes.school;
    dateTime = json['dateTime'] != null ? DateTime.parse(json['dateTime']) : DateTime.now();
    allDay = json['allDay'] ?? false;
    links = ((json['links'] ?? []) as List).map((l) => EventLink.fromJson(l)).toList();
  }

}