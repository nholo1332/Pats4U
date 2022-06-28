import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pats4u/models/announcement.dart';
import 'package:pats4u/models/feed.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';

class Announcements extends StatefulWidget {
  const Announcements({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnnouncementsState();
  }
}

class _AnnouncementsState extends State<Announcements> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinimalAppBar(
        height: 65,
        title: 'Announcements',
        leftIcon: Icons.chevron_left,
        leftAction: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: buildBody(),
        ),
      ),
    );
  }

  List<Widget> buildBody() {
    // Add widgets to list of widgets to be returned to view
    List<Widget> items = [];
    items.add(
      FutureBuilder(
        future: Backend.getFeed(),
        builder: (BuildContext context, AsyncSnapshot<Feed> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: buildContent(snapshot.data!),
                ),
              ),
            );
          } else {
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
        },
      ),
    );
    return items;
  }

  List<Widget> buildContent(Feed feed) {
    // Build the Feed item based on returned data
    List<Widget> items = [];
    if (feed.announcements.isNotEmpty) {
      items.addAll(
        List.generate(
          feed.announcements.length,
            (index) => buildAnnouncement(feed.announcements[index]),
        ),
      );
    } else {
      items.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(
              height: 75,
            ),
            Center(
              child: Icon(
              Icons.campaign,
                size: 65,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                'No Announcements',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return items;
  }

  Widget buildAnnouncement(Announcement announcement) {
    // Build the announcement card
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: const Icon(Icons.campaign),
              title: Text(
                announcement.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                announcement.content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                openInfoDialog(announcement.title, announcement.content);
              },
            ),
          ],
        ),
      ),
    );
  }

  openInfoDialog(String title, String content) {
    // Display dialog with sent information
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
