import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pats4u/models/event.dart';
import 'package:pats4u/providers/event_helpers.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/widgets/image_container.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarEventDetailView extends StatefulWidget {
  final Event event;

  const CalendarEventDetailView({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalendarEventDetailViewState();
  }
}

class _CalendarEventDetailViewState extends State<CalendarEventDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MinimalAppBar(
        title: '',
        height: 65,
        leftIcon: Icons.chevron_left,
        leftAction: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    DateFormat dateFormat = DateFormat('EEEE, MMM d');
    DateFormat timeFormat = DateFormat('- h:mm a');
    List<Widget> items = [];
    items.add(
      Row(
        children: [
          Icon(
            EventHelpers.getIcon(widget.event.eventType),
            size: 40,
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Text(
              widget.event.title,
              maxLines: 3,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical * 2.2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
    items.add(
      Row(
        children: [
          const SizedBox(
            width: 70,
          ),
          Text(
            dateFormat.format(widget.event.dateTime) + ( widget.event.allDay ? ' - All-Day Event' : timeFormat.format(widget.event.dateTime)),
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 1.7,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
    if ( widget.event.location != '' || widget.event.mapsLink != '' ) {
      items.add(
        const SizedBox(
          height: 25,
        ),
      );
      items.add(
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: const Icon(Icons.room),
                title: Text(
                  widget.event.location,
                ),
                subtitle: widget.event.mapsLink != '' ? const Text('Click for directions') : null,
                onTap: widget.event.mapsLink != '' ? () async {
                  if ( await canLaunch(widget.event.mapsLink) ) {
                    launch(widget.event.mapsLink);
                  }
                } : null,
              ),
            ),
          ],
        ),
      );
    }
    if ( widget.event.links.isNotEmpty ) {
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
          widget.event.links.length,
          (index) => Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.link),
                  title: Text(widget.event.links[index].name),
                  subtitle: Text(
                    widget.event.links[index].link,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                  onTap: () async {
                    if ( await canLaunch(widget.event.links[index].link) ) {
                      launch(widget.event.links[index].link);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    if ( widget.event.isUserEvent ) {
      items.add(
        const SizedBox(
          height: 25,
        ),
      );
      items.add(
        Row(
          children: const [
            Expanded(
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text('Event created by you'),
              ),
            ),
          ],
        ),
      );
    }
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ImageContainer(
          image: 'assets/images/' + widget.event.eventType.name + '.png',
          isNetwork: false,
          isShadow: false,
          width: SizeConfig.screenWidth,
          height: 300,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 270,
          ),
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                right: 25,
                left: 25,
              ),
              child: Column(
                children: items,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
