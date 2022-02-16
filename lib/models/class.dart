class Class {
  // Create model variables
  String id = '';
  String title = '';
  String teacher = '';
  String description = '';
  int period = 0;

  Class();

  // Convert JSON to data model variables
  Class.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    teacher = json['teacher'] ?? '';
    description = json['description'] ?? '';
    period = json['period'] ?? 0;
  }
}
