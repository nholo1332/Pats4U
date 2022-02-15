class User {
  String name = '';

  User();

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
  }
}
