import 'package:pats4u/models/announcement.dart';
import 'package:pats4u/models/event_update.dart';
import 'package:pats4u/models/faceBookPost.dart';
import 'package:pats4u/models/game_result.dart';
import 'package:pats4u/models/youTubeVideo.dart';

class Feed {
  // Create model variables
  List<GameResult> gameResults = [];
  List<EventUpdate> eventUpdates = [];
  List<Announcement> announcements = [];
  List<YouTubeVideo> youTubeVideo = [];
  List<FaceBookPost> faceBookPosts = [];

  Feed();

  // Convert JSON to data model variables
  Feed.fromJson(Map<String, dynamic> json) {
    gameResults = ((json['gameResults'] ?? []) as List)
        .map((m) => GameResult.fromJson(m))
        .toList();
    eventUpdates = ((json['eventUpdates'] ?? []) as List)
        .map((m) => EventUpdate.fromJson(m))
        .toList();
    announcements = ((json['announcements'] ?? []) as List)
        .map((m) => Announcement.fromJson(m))
        .toList();
    youTubeVideo = ((json['youtube'] ?? []) as List)
        .map((m) => YouTubeVideo.fromJson(m))
        .toList();
    faceBookPosts = ((json['facebook'] ?? []) as List)
        .map((m) => FaceBookPost.fromJson(m))
        .toList();
  }
}
