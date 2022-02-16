class CalendarStreamEvent {
  // Create model variables
  late DateTime dateTime;
  bool forceUpdate = false;

  CalendarStreamEvent();

  // Function to return an instance of this model with data
  CalendarStreamEvent.create(DateTime _dateTime, {bool force = false}) {
    dateTime = _dateTime;
    forceUpdate = force;
  }
}
