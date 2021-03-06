class LunchMenuItem {
  // Create model variables
  String day = '';
  String main = '';
  List<String> sides = [];
  String desert = '';
  List<String> extras = [];
  String image = '';
  DateTime date = DateTime.now();

  LunchMenuItem();

  // Convert JSON to data model variables
  LunchMenuItem.fromJson(Map<String, dynamic> json) {
    day = json['day'] ?? '';
    main = json['main'] ?? '';
    sides = List.from(json['sides'] ?? []);
    desert = json['desert'] ?? '';
    extras = List.from(json['extras'] ?? []);
    image = json['image'] ?? '';
    date = json['date'] != null ? DateTime.parse(json['date']) : DateTime.now();
  }
}
