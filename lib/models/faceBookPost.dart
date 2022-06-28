import 'package:pats4u/models/faceBookPicture.dart';

class FaceBookPost {
  // Create model variables
  String text = '';
  DateTime date = DateTime.now();
  String link = '';
  List<FaceBookPicture> pictures = [];

  FaceBookPost();

  // Convert JSON to data model variables
  FaceBookPost.fromJson(Map<String, dynamic> json) {
    text = json['text'] ?? '';
    date = json['date'] != null
        ? DateTime.parse(json['date']).toLocal()
        : DateTime.now();
    link = json['link'] ?? '';
    pictures = ((json['pictures'] ?? []) as List)
        .map((m) => FaceBookPicture.fromJson(m))
        .toList();
  }
}
