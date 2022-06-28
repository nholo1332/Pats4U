import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:intl/intl.dart';
import 'package:pats4u/models/event_update.dart';
import 'package:pats4u/models/face_book_post.dart';
import 'package:pats4u/models/feed.dart';
import 'package:pats4u/models/game_result.dart';
import 'package:pats4u/models/you_tube_video.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/event_helpers.dart';
import 'package:pats4u/providers/feed_image_cache_provider.dart';
import 'package:pats4u/providers/mascot_image_cache_provider.dart';
import 'package:pats4u/views/announcements/announcements.dart';
import 'package:pats4u/views/settings/settings.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
        rightIcon: Icons.campaign,
        rightAction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Announcements(),
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
    var content = [];
    content.addAll(feed.eventUpdates);
    content.addAll(feed.gameResults);
    content.addAll(feed.youTubeVideo);
    content.addAll(feed.faceBookPosts);
    content.sort((a, b) {
      if ( (a is EventUpdate || a is GameResult || a is YouTubeVideo || a is FaceBookPost) && (b is EventUpdate || b is GameResult || b is YouTubeVideo || b is FaceBookPost) ) {
        return b.date.compareTo(a.date);
      }
      return 0;
    });
    List<Widget> items = [];
    items.addAll(
      List.generate(
        content.length,
        (index) {
          var feedItem = content[index];
          Widget header = Container();
          Widget body = Container();

          if (feedItem is EventUpdate) {
            header = ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: const Icon(Icons.info),
              title: const Text(
                'Event Update',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                DateFormat('MMM dd, yyyy').format(feedItem.date),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
            body = buildEventUpdate(feedItem);
          } else if (feedItem is GameResult) {
            header = ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: const Icon(Icons.score),
              title: const Text(
                'Game Update',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  FlutterShareMe flutterShareMe = FlutterShareMe();
                  String shareText = '';
                  if (feedItem.finalResult && feedItem.home.score > feedItem.guest.score) {
                    shareText = 'Patriots defeated the ' + feedItem.guest.name + ' ' + feedItem.sport.toString().split('.')[1] + ' team ' + feedItem.home.score.toString() + '-' + feedItem.guest.score.toString() + '!';
                  } else if (feedItem.finalResult && feedItem.home.score < feedItem.guest.score) {
                    shareText = 'Patriots lost the battle against the ' + feedItem.guest.name + ' ' + feedItem.sport.toString().split('.')[1] + ' team ' + feedItem.home.score.toString() + '-' + feedItem.guest.score.toString();
                  } else {
                    shareText = 'Patriots are currently battling the ' + feedItem.guest.name + ' ' + feedItem.sport.toString().split('.')[1] + ' team with a score of ' + feedItem.home.score.toString() + '-' + feedItem.guest.score.toString();
                  }
                  flutterShareMe.shareToSystem(msg: shareText);
                },
              ),
            );
            body = buildGameResult(feedItem);
          } else if (feedItem is YouTubeVideo) {
            header = ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: const Icon(Icons.video_collection),
              title: const Text(
                'YouTube Video',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                DateFormat('MMM dd, yyyy').format(feedItem.date),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  FlutterShareMe flutterShareMe = FlutterShareMe();
                  String shareText = 'Check out the ' + feedItem.title + ' video on YouTube: https://youtube.com/watch?v=' + feedItem.id;
                  flutterShareMe.shareToSystem(msg: shareText);
                },
              ),
            );
            body = buildYouTubeVideo(feedItem);
          } else if (feedItem is FaceBookPost) {
            header = ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: const Icon(Icons.facebook),
              title: const Text(
                'Facebook Post',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                DateFormat('MMM dd, yyyy').format(feedItem.date),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
            body = buildFacebookPost(feedItem);
          }

          return Container(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  header,
                  body,
                ],
              ),
            ),
          );
        },
      ),
    );
    items.add(
      const SizedBox(
        height: 100,
      ),
    );
    return items;
  }

  Widget buildYouTubeVideo(YouTubeVideo youTubeVideo) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: youTubeVideo.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          child: player,
        );
      }
    );
  }

  Widget buildFacebookPost(FaceBookPost faceBookPost) {
    List<Widget> items = [];
    if (faceBookPost.text != '') {
      items.add(Text(faceBookPost.text));
    }
    if (faceBookPost.pictures.isNotEmpty) {
      items.add(
        Container(
          padding: const EdgeInsets.only(top: 15),
          child: FutureBuilder(
            future: FeedImageCacheManager()
                .getSingleFile(faceBookPost.pictures[0].url),
            builder: (context, AsyncSnapshot<File> snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.done &&
                  snapshot.data != null) {
                return Image(image: FileImage(snapshot.data!));
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
      );
    }
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Column(
        children: items,
      ),
    );
  }

  Widget buildGameResult(GameResult gameResult) {
    // Create the game result container (with mascots and scores)
    DateFormat dateFormat = DateFormat('MMM dd');
    return Column(
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
            Expanded(
              child: (gameResult.finalResult && gameResult.home.score > gameResult.guest.score) ? const Icon(
                Icons.workspace_premium,
                color: Colors.amberAccent,
                size: 25,
              ) : Container(),
            ),
            Expanded(
              child: Icon(
                EventHelpers.getIcon(gameResult.sport),
                size: 25,
              ),
            ),
            Expanded(
              child: (gameResult.finalResult && gameResult.home.score < gameResult.guest.score) ? const Icon(
                Icons.workspace_premium,
                color: Colors.amberAccent,
                size: 25,
              ) : Container(),
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
                      future: MascotImageCacheManager()
                          .getSingleFile(gameResult.home.mascot),
                      builder: (context, AsyncSnapshot<File> snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.done &&
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
                    gameResult.home.score.toString() +
                        ' - ' +
                        gameResult.guest.score.toString(),
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
                      child: Text(
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
                      future: MascotImageCacheManager()
                          .getSingleFile(gameResult.guest.mascot),
                      builder: (context, AsyncSnapshot<File> snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.done &&
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
        Row(
          children: const [
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildEventUpdate(EventUpdate eventUpdate) {
    // Display list of Cards with event updates
    DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        eventUpdate.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        eventUpdate.content,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        openInfoDialog(
            eventUpdate.title,
            eventUpdate.content +
                '\n\n' +
                dateFormat.format(eventUpdate.date));
      },
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
