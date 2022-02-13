import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pats4u/models/event.dart';
import 'package:pats4u/providers/backend.dart';

import '../../models/calendar_stream_event.dart';
import '../../models/months.dart';

class CalendarContentView extends StatefulWidget {
  final Stream<CalendarStreamEvent> dateStream;

  const CalendarContentView({
    required this.dateStream,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalendarContentView();
  }
}

class _CalendarContentView extends State<CalendarContentView> {
  List<Event> monthEvents = [];
  List<Event> dayEvents = [];
  DateTime? selectedMonthEvents;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.dateStream,
      builder: (BuildContext context, AsyncSnapshot<CalendarStreamEvent> snapshot) {
        if ( snapshot.data != null ) {
          return loadMonthEvents(snapshot.data!.dateTime, snapshot.data!.forceUpdate);
        } else {
          return buildLoading();
        }
      },
    );
  }

  getTodayEvents(DateTime date) {
    final dateFormat = DateFormat('MM/dd/yyyy');
    dayEvents = monthEvents.where((event) => dateFormat.format(event.dateTime) == dateFormat.format(date)).toList();
  }

  Widget loadMonthEvents(DateTime newDate, bool forceUpdate) {
    final dateFormat = DateFormat('MM/yyyy');
    if ( selectedMonthEvents != null && dateFormat.format(newDate) == dateFormat.format(selectedMonthEvents ?? DateTime.now()) && !forceUpdate ) {
      getTodayEvents(newDate);
      return buildEvents();
    } else {
      return FutureBuilder(
        future: Backend.getMonthEvents(Months.values[newDate.month - 1], force: forceUpdate),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if ( snapshot.connectionState == ConnectionState.done && snapshot.data != null ) {
            selectedMonthEvents = newDate;
            monthEvents = snapshot.data!;
            getTodayEvents(newDate);
            return buildEvents();
          } else {
            return buildLoading();
          }
        },
      );
    }
  }

  Widget buildLoading() {
    return const Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget buildEvents() {
    return Container();
  }
}
