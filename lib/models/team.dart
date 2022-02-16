class Team {
  // Create model variables
  String name = '';
  String mascot = '';
  int score = 0;

  Team();

  // Convert JSON to data model variables
  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    mascot = json['mascot'] ?? '';
    score = json['score'] ?? '';
  }
}
