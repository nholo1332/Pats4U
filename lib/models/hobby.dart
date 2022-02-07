class Hobby {

  String title = '';
  String description = '';
  String icon = '';

  Hobby();

  Hobby.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    icon = json['icon'] ?? '';
  }

}