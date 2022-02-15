import 'package:flutter/material.dart';
import 'package:pats4u/models/event_types.dart';

class EventHelpers {
  static IconData getIcon(EventTypes eventType) {
    switch (eventType) {
      case EventTypes.basketball:
        return Icons.sports_basketball;
      case EventTypes.football:
        return Icons.sports_football;
      case EventTypes.volleyball:
        return Icons.sports_volleyball;
      case EventTypes.wrestling:
        return Icons.sports_kabaddi;
      case EventTypes.track:
        return Icons.directions_run;
      case EventTypes.golf:
        return Icons.sports_golf;
      case EventTypes.school:
        return Icons.school;
      case EventTypes.other:
        return Icons.local_activity;
    }
  }
}
