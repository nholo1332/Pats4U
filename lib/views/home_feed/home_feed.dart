import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:intl/intl.dart';
import 'package:pats4u/models/announcement.dart';
import 'package:pats4u/models/event_update.dart';
import 'package:pats4u/models/feed.dart';
import 'package:pats4u/models/game_result.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/event_helpers.dart';
import 'package:pats4u/providers/mascot_image_cache_provider.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/views/settings/settings.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeFeedState();
  }
}

class _HomeFeedState extends State<HomeFeed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinimalAppBar(
        height: 65,
        title: 'Patriot Feed',
        leftIcon: Icons.settings,
        leftAction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Settings(),
            ),
          );
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
    // Build the Patriot icon and FutureBuilder for Feed
    List<Widget> items = [];
    items.add(
      Center(
        child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/CLPats.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
    items.add(
      FutureBuilder(
        future: Backend.getFeed(),
        builder: (BuildContext context,
            AsyncSnapshot<Feed> snapshot) {
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
    if ( feed.announcements.isNotEmpty ) {
      items.add(
        Row(
          children: [
            Text(
              'Announcements',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.2,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      );
      items.add(
        const SizedBox(
          height: 15,
        ),
      );
      items.add(
        CarouselSlider(
          options: CarouselOptions(
            height: 115,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: .8,
            enableInfiniteScroll: false,
          ),
          items: List.generate(
            feed.announcements.length,
                (index) => buildAnnouncement(feed.announcements[index]),
          ),
        ),
      );
    }
    if ( feed.announcements.isNotEmpty && ( feed.gameResults.isNotEmpty || feed.eventUpdates.isNotEmpty ) ) {
      items.add(
        const SizedBox(
          height: 25,
        ),
      );
    }
    if ( feed.gameResults.isNotEmpty ) {
      items.add(
        Row(
          children: [
            Text(
              'Game Results',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.2,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      );
      items.add(
        const SizedBox(
          height: 15,
        ),
      );
      items.add(
        CarouselSlider(
          options: CarouselOptions(
            height: 185,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: .8,
            enableInfiniteScroll: false,
          ),
          items: List.generate(
            feed.gameResults.length,
                (index) => buildGameResult(feed.gameResults[index]),
          ),
        ),
      );
    }
    if ( feed.eventUpdates.isNotEmpty && ( feed.gameResults.isNotEmpty || feed.announcements.isNotEmpty ) ) {
      items.add(
        const SizedBox(
          height: 25,
        ),
      );
    }
    if ( feed.eventUpdates.isNotEmpty ) {
      items.add(
        Row(
          children: [
            Text(
              'Event Updates',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.2,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      );
      items.add(
        const SizedBox(
          height: 15,
        ),
      );
      items.add(
        CarouselSlider(
          options: CarouselOptions(
            height: 115,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: .8,
            enableInfiniteScroll: false,
          ),
          items: List.generate(
            feed.eventUpdates.length,
                (index) => buildEventUpdate(feed.eventUpdates[index]),
          ),
        ),
      );
    }
    items.add(
      const SizedBox(
        height: 125,
      ),
    );
    return items;
  }

  Widget buildAnnouncement(Announcement announcement) {
    // Build the announcement card
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        leading: const Icon(Icons.info),
        title: Text(
          announcement.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          announcement.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          openInfoDialog(announcement.title, announcement.content);
        },
      ),
    );
  }

  Widget buildGameResult(GameResult gameResult) {
    // Create the game result container (with mascots and scores)
    DateFormat dateFormat = DateFormat('MMM dd');
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.08),
            spreadRadius: 0.5,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: const [
              SizedBox(
                height: 15,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                EventHelpers.getIcon(gameResult.sport),
                size: 25,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(dateFormat.format(gameResult.date)),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: FutureBuilder(
                        future: MascotImageCacheManager().getSingleFile(gameResult.home.mascot),
                        builder: (context, AsyncSnapshot<File> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.data != null) {
                            return Container(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              height: 65,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(snapshot.data!),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox(
                              height: 65,
                              width: 65,
                              child: Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Center(
                      child: Text(gameResult.home.name),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      gameResult.home.score.toString() + ' - ' + gameResult.guest.score.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 20,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child:  Text(
                          gameResult.finalResult ? 'Final' : 'Active',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: FutureBuilder(
                        future: MascotImageCacheManager().getSingleFile(gameResult.guest.mascot),
                        builder: (context, AsyncSnapshot<File> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.data != null) {
                            return Container(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              height: 65,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(snapshot.data!),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox(
                              height: 65,
                              width: 65,
                              child: Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Center(
                      child: Text(gameResult.guest.name),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildEventUpdate(EventUpdate eventUpdate) {
    // Display list of Cards with event updates
    DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        leading: const Icon(Icons.info),
        title: Text(
          eventUpdate.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          eventUpdate.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          openInfoDialog(eventUpdate.title, eventUpdate.content + '\n\n' + dateFormat.format(eventUpdate.date));
        },
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
