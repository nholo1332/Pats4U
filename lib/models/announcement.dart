class Announcement {
  // Create model variables
  String title = '';
  String content = '';

  Announcement();

  // Convert JSON to data model variables
  Announcement.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    content = json['content'] ?? '';
  }
}
