class YouTubeVideo {
  // Create model variables
  String title = '';
  DateTime date = DateTime.now();
  String poster = '';
  String id = '';

  YouTubeVideo();

  // Convert JSON to data model variables
  YouTubeVideo.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    date = json['date'] != null
        ? DateTime.parse(json['date']).toLocal()
        : DateTime.now();
    poster = json['poster'] ?? '';
    id = json['id'] ?? '';
  }
}
