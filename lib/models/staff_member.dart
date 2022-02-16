import 'package:pats4u/models/fun_fact.dart';
import 'package:pats4u/models/hobby.dart';

class StaffMember {
  // Create model variables
  String id = '';
  String name = '';
  String picture = '';
  String email = '';
  String phone = '';
  String bio = '';
  List<String> classes = [];
  List<FunFact> funFacts = [];
  List<Hobby> hobbies = [];

  StaffMember();

  // Convert JSON to data model variables
  StaffMember.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    picture = json['picture'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    bio = json['bio'] ?? '';
    classes = List.from(json['classes'] ?? []);
    funFacts = ((json['funFacts'] ?? []) as List)
        .map((f) => FunFact.fromJson(f))
        .toList();
    hobbies = ((json['hobbies'] ?? []) as List)
        .map((h) => Hobby.fromJson(h))
        .toList();
  }
}
