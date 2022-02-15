class BugReportModel {
  String location = '';
  String description = '';
  String reproductionSteps = '';
  String deviceInfo = '';

  BugReportModel();

  BugReportModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] ?? '';
    description = json['description'] ?? '';
    reproductionSteps = json['reproductionSteps'] ?? '';
    deviceInfo = json['deviceInfo'] ?? '';
  }

  Map<String, dynamic> toJSON() {
    return {
      'location': location,
      'description': description,
      'reproductionSteps': reproductionSteps,
      'deviceInfo': deviceInfo,
    };
  }
}
