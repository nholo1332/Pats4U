class EventLink {
  String name = '';
  String link = '';

  EventLink();

  EventLink.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    link = json['link'] ?? '';
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'link': link,
    };
  }
}
