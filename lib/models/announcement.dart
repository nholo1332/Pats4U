class Announcement {
  String title = '';
  String content = '';

  Announcement();

  Announcement.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    content = json['content'] ?? '';
  }
}
