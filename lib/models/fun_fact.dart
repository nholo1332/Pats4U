class FunFact {

  String title = '';
  String description = '';

  FunFact();

  FunFact.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    description = json['description'] ?? '';
  }

}