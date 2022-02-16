class Team {
  String name = '';
  String mascot = '';
  int score = 0;

  Team();

  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    mascot = json['mascot'] ?? '';
    score = json['score'] ?? '';
  }
}
