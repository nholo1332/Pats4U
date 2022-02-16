class FunFact {
  // Create model variables
  String title = '';
  String description = '';

  FunFact();

  // Convert JSON to data model variables
  FunFact.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    description = json['description'] ?? '';
  }
}
