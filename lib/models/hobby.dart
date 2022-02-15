class Hobby {
  String title = '';
  String description = '';
  int icon = 0;

  Hobby();

  Hobby.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    icon = int.tryParse((json['icon'] ?? 'a').toString()) != null
        ? int.parse((json['icon']).toString())
        : 0;
  }
}
