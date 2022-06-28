class FaceBookPicture {
  // Create model variables
  String url = '';

  FaceBookPicture();

  // Convert JSON to data model variables
  FaceBookPicture.fromJson(Map<String, dynamic> json) {
    url = json['url'] ?? '';
  }
}
