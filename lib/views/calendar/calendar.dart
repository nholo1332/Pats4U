import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pats4u/libraries/calendar_timeline/calendar_timeline.dart';
import 'package:pats4u/models/calendar_stream_event.dart';
import 'package:pats4u/providers/auth.dart';
import 'package:pats4u/views/calendar/create_event.dart';
import 'package:pats4u/views/login/login.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';
import 'calendar_content_view.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalendarState();
  }
}

class _CalendarState extends State<Calendar> {
  StreamController<CalendarStreamEvent> dateStreamController = StreamController<CalendarStreamEvent>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      dateStreamController.add(CalendarStreamEvent.create(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinimalAppBar(
        title: 'Scheduling',
        height: 65,
        rightIcon: Icons.add,
        rightAction: addButtonClick,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
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
                dateStreamController.add(CalendarStreamEvent.create(date));
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

  addButtonClick() {
    if ( Auth.getUser() != null ) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateEvent(),
        ),
      ).then((value) {
        dateStreamController.add(
          CalendarStreamEvent.create(
            DateTime.now(),
            force: true,
          ),
        );
      });
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login to Add Events'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Before adding events to your calendar, you must first login.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Login'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }
}
