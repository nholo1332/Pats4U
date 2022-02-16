class BugReportModel {
  // Create model variables
  String location = '';
  String description = '';
  String reproductionSteps = '';
  String deviceInfo = '';

  BugReportModel();

  // Convert JSON to data model variables
  BugReportModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] ?? '';
    description = json['description'] ?? '';
    reproductionSteps = json['reproductionSteps'] ?? '';
    deviceInfo = json['deviceInfo'] ?? '';
  }

  // Convert data model variables to JSON
  Map<String, dynamic> toJSON() {
    return {
      'location': location,
      'description': description,
      'reproductionSteps': reproductionSteps,
      'deviceInfo': deviceInfo,
    };
  }
}
