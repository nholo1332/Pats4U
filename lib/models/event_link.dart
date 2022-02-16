class EventLink {
  // Create model variables
  String name = '';
  String link = '';

  EventLink();

  // Convert JSON to data model variables
  EventLink.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    link = json['link'] ?? '';
  }

  // Convert data model variables to JSON
  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'link': link,
    };
  }
}
