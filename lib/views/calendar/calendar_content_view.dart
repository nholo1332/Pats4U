import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pats4u/models/event.dart';
import 'package:pats4u/providers/backend.dart';

import '../../models/months.dart';

class CalendarContentView extends StatefulWidget {
  final Stream<DateTime> dateStream;

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
  DateTime? selectedMonthEvents;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.dateStream,
      builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
        if ( snapshot.data != null ) {
          return loadMonthEvents(snapshot.data!);
        } else {
          return buildLoading();
        }
      },
    );
  }

  Widget loadMonthEvents(DateTime newDate) {
    final dateFormat = DateFormat('MM/yyyy');
    if ( selectedMonthEvents != null && dateFormat.format(newDate) == dateFormat.format(selectedMonthEvents ?? DateTime.now()) ) {
      return buildEvents();
    } else {
      return FutureBuilder(
        future: Backend.getMonthEvents(Months.values[newDate.month - 1]),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if ( snapshot.connectionState == ConnectionState.done && snapshot.data != null ) {
            selectedMonthEvents = newDate;
            monthEvents = snapshot.data!;
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
