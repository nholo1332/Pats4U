import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pats4u/models/event.dart';
import 'package:pats4u/models/event_link.dart';
import 'package:pats4u/models/event_types.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateEvent extends StatefulWidget {
  final Event? editEvent;

  const CreateEvent({
    this.editEvent,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreateEventState();
  }
}

class _CreateEventState extends State<CreateEvent> {
  bool saving = false;
  Event event = Event();

  @override
  void initState() {
    super.initState();
    if (widget.editEvent != null && (widget.editEvent ?? Event()).id != '') {
      event = widget.editEvent!;
    } else {
      event.isUserEvent = true;
      event.eventType = EventTypes.other;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MinimalAppBar(
          title: 'Create Event',
          height: 65,
          leftIcon: Icons.chevron_left,
          leftAction: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 25,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: buildBody(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildBody() {
    // Add widgets to create the create event form
    List<Widget> items = [];
    items.add(
      Row(
        children: [
          Text(
            'Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
    items.add(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextFormField(
          enabled: !saving,
          initialValue: event.title,
          onChanged: (value) {
            event.title = value;
          },
          decoration: const InputDecoration(
            hintText: 'Name',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
    items.add(
      const SizedBox(
        height: 25,
      ),
    );
    items.add(
      Row(
        children: [
          Text(
            'Time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
    items.add(
      SwitchListTile(
        title: const Text('All-Day Event'),
        value: event.allDay,
        onChanged: (bool value) {
          setState(() {
            event.allDay = value;
          });
        },
      ),
    );
    items.add(
      ListTile(
        title: const Text('Day'),
        trailing: Text(DateFormat('MM/dd/yyyy').format(event.dateTime)),
        onTap: selectDate,
      ),
    );
    if (!event.allDay) {
      items.add(
        ListTile(
          title: const Text('Time'),
          trailing: Text(DateFormat('hh:mm a').format(event.dateTime)),
          onTap: selectTime,
        ),
      );
    }
    items.add(
      const SizedBox(
        height: 25,
      ),
    );
    items.add(
      Row(
        children: [
          Text(
            'Location',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
    items.add(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextFormField(
          enabled: !saving,
          initialValue: event.location,
          onChanged: (value) {
            event.location = value;
          },
          decoration: const InputDecoration(
            hintText: 'Location',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
    items.add(
      const SizedBox(
        height: 25,
      ),
    );
    items.add(
      Row(
        children: [
          Text(
            'Other Info',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
    items.add(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextFormField(
          enabled: !saving,
          initialValue: event.description,
          maxLines: 5,
          onChanged: (value) {
            event.description = value;
          },
          decoration: const InputDecoration(
            hintText: 'Description',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
    items.add(
      const SizedBox(
        height: 25,
      ),
    );
    items.add(
      Row(
        children: [
          Text(
            'Links',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
    items.addAll(
      List.generate(
        event.links.length,
        (index) => Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(
                  event.links[index].name,
                ),
                subtitle: Text(
                  event.links[index].link,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.link),
                      color: Theme.of(context).colorScheme.onBackground,
                      onPressed: saving
                          ? null
                          : () async {
                              if (await canLaunch(event.links[index].link)) {
                                launch(event.links[index].link);
                              }
                            },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: saving
                          ? null
                          : () {
                              setState(() {
                                event.links.removeAt(index);
                              });
                            },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    items.add(
      const SizedBox(
        height: 10,
      ),
    );
    items.add(
      Align(
        alignment: Alignment.bottomLeft,
        child: OutlinedButton(
          child: const Text('Add Link'),
          onPressed: saving ? null : addLink,
        ),
      ),
    );
    items.add(
      const SizedBox(
        height: 25,
      ),
    );
    if (event.id == '') {
      items.add(
        const Center(
          child: Text('This event is only viewable by you.'),
        ),
      );
      items.add(
        const SizedBox(
          height: 15,
        ),
      );
    }
    items.add(
      Container(
        height: 56,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: saving ? null : saveEvent,
            borderRadius: BorderRadius.circular(14),
            child: Center(
              child: saving
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onPrimary),
                    )
                  : Text(
                      event.id == '' ? 'Create' : 'Save',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
    items.add(
      const SizedBox(
        height: 25,
      ),
    );
    return items;
  }

  selectDate() async {
    // Show date picker
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year, 1, 1),
      lastDate: DateTime(DateTime.now().year, 12, 31),
      initialDate: event.dateTime,
    );
    if (date != null) {
      setState(() {
        event.dateTime = date;
      });
    }
  }

  selectTime() async {
    // Show time picker
    TimeOfDay? t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(event.dateTime),
    );
    if (t != null) {
      setState(() {
        event.dateTime = DateTime(event.dateTime.year, event.dateTime.month,
            event.dateTime.day, t.hour, t.minute);
      });
    }
  }

  addLink() {
    // Open dialog to enter new link information
    EventLink eventLink = EventLink();
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Link'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextFormField(
                    initialValue: eventLink.name,
                    onChanged: (value) {
                      eventLink.name = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextFormField(
                    initialValue: eventLink.link,
                    onChanged: (value) {
                      eventLink.link = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Link',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (eventLink.name != '' && eventLink.link != '') {
                  setState(() {
                    if (!eventLink.link.contains('http://') ||
                        !eventLink.link.contains('https://')) {
                      eventLink.link = 'https://' + eventLink.link;
                    }
                    event.links.add(eventLink);
                    Navigator.of(context).pop();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  saveEvent() {
    // Create or save event to server (authenticated request)
    if (event.title != '' && event.id == '') {
      setState(() {
        saving = true;
      });
      Backend.addEvent(event).then((value) {
        Navigator.of(context).pop(true);
      }).catchError((error) {
        setState(() {
          saving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to save event.'),
            duration: const Duration(
              seconds: 3,
            ),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {},
            ),
          ),
        );
      });
    } else if (event.title != '' && event.id != '') {
      setState(() {
        saving = true;
      });
      Backend.updateEvent(event).then((value) {
        Navigator.of(context).pop(true);
      }).catchError((error) {
        setState(() {
          saving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to save event.'),
            duration: const Duration(
              seconds: 3,
            ),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {},
            ),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter an event name.'),
          duration: const Duration(
            seconds: 3,
          ),
          action: SnackBarAction(
            label: 'Ok',
            textColor: Theme.of(context).colorScheme.onError,
            onPressed: () {},
          ),
        ),
      );
    }
  }
}
