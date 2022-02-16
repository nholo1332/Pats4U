class User {
  // Create model variables
  String name = '';

  User();

  // Convert JSON to data model variables
  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
  }
}
