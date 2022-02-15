import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pats4u/models/event.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/views/calendar/calendar_event_detail_view.dart';
import 'package:pats4u/views/calendar/create_event.dart';

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
      builder:
          (BuildContext context, AsyncSnapshot<CalendarStreamEvent> snapshot) {
        if (snapshot.data != null) {
          return loadMonthEvents(
              snapshot.data!.dateTime, snapshot.data!.forceUpdate);
        } else {
          return buildLoading();
        }
      },
    );
  }

  getTodayEvents(DateTime date) {
    final dateFormat = DateFormat('MM/dd/yyyy');
    dayEvents = monthEvents
        .where((event) =>
            dateFormat.format(event.dateTime) == dateFormat.format(date))
        .toList();
  }

  Widget loadMonthEvents(DateTime newDate, bool forceUpdate) {
    final dateFormat = DateFormat('MM/yyyy');
    if (selectedMonthEvents != null &&
        dateFormat.format(newDate) ==
            dateFormat.format(selectedMonthEvents ?? DateTime.now()) &&
        !forceUpdate) {
      getTodayEvents(newDate);
      return buildEvents();
    } else {
      return FutureBuilder(
        future: Backend.getMonthEvents(Months.values[newDate.month - 1],
            force: forceUpdate),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
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
    DateFormat dateFormat = DateFormat('h:mm');
    DateFormat amPmDateFormat = DateFormat('a');
    List<Widget> widgets = [];
    List<Event> allDayEvents =
        dayEvents.where((event) => event.allDay).toList();
    allDayEvents.sort((a, b) => a.title.compareTo(b.title));
    List<Event> timeEvents = dayEvents.where((event) => !event.allDay).toList();
    timeEvents.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    if (allDayEvents.isNotEmpty) {
      widgets.add(
        Row(
          children: [
            Text(
              'All-Day Events',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.5,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      );
      widgets.addAll(
        List.generate(
          allDayEvents.length,
          (index) => Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.today),
                  title: Text(allDayEvents[index].title),
                  subtitle: Text(
                    allDayEvents[index].description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: (allDayEvents[index].isUserEvent)
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () {
                                editEvent(allDayEvents[index]);
                              },
                            ),
                          ],
                        )
                      : null,
                  onTap: () {
                    openEvent(allDayEvents[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (allDayEvents.isNotEmpty && timeEvents.isNotEmpty) {
      widgets.add(
        const SizedBox(
          height: 25,
        ),
      );
      widgets.add(
        Row(
          children: [
            Text(
              'Events',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.5,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      );
    }
    widgets.addAll(
      List.generate(
        timeEvents.length,
        (index) => Row(
          children: [
            Expanded(
              child: ListTile(
                leading: FittedBox(
                  fit: BoxFit.fill,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            dateFormat.format(timeEvents[index].dateTime),
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            amPmDateFormat.format(timeEvents[index].dateTime),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                title: Text(timeEvents[index].title),
                subtitle: Text(
                  timeEvents[index].description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: (timeEvents[index].isUserEvent)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {
                              editEvent(timeEvents[index]);
                            },
                          ),
                        ],
                      )
                    : null,
                onTap: () {
                  openEvent(timeEvents[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
    if (allDayEvents.isEmpty && timeEvents.isEmpty) {
      widgets.add(
        const SizedBox(
          height: 25,
        ),
      );
      widgets.add(
        Center(
          child: Text(
            'There are no events today.',
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  openEvent(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarEventDetailView(
          event: event,
        ),
      ),
    );
  }

  editEvent(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateEvent(
          editEvent: event,
        ),
      ),
    ).then((value) => {
          if (value == true) {setState(() {})}
        });
  }
}
