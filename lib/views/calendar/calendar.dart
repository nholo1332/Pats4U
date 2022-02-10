import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pats4u/libraries/calendar_timeline/calendar_timeline.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';
import 'calendar_content_view.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Calendar();
  }
}

class _Calendar extends State<Calendar> {
  StreamController<DateTime> dateStreamController = StreamController<DateTime>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      dateStreamController.add(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MinimalAppBar(
        title: 'Scheduling',
        height: 65,
      ),
      body: Column(
        children: [
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year, 1, 1),
            lastDate: DateTime(DateTime.now().year, 12, 31),
            dayColor: Theme.of(context).colorScheme.primary,
            activeDayColor: Theme.of(context).colorScheme.onSecondary,
            activeBackgroundDayColor:Theme.of(context).colorScheme.secondary,
            dotsColor: Theme.of(context).colorScheme.onSecondary.withOpacity(0.9),
            leftMargin: 40,
            locale: 'en_ISO',
            onDateSelected: (date) {
              if ( date != null ) {
                dateStreamController.add(date);
              }
            },
          ),
          CalendarContentView(
            dateStream: dateStreamController.stream,
          ),
        ],
      ),
    );
  }
}
