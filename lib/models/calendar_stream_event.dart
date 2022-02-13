class CalendarStreamEvent {
  late DateTime dateTime;
  bool forceUpdate = false;

  CalendarStreamEvent();

  CalendarStreamEvent.create(DateTime _dateTime, {bool force = false}) {
    dateTime = _dateTime;
    forceUpdate = force;
  }
}