class ErrorModel {
  Map<String, dynamic> errors;
  String name;

  ErrorModel.fromJson(Map<String, dynamic> parsedJson) {
    errors = parsedJson['errors'];
    name = parsedJson['name']?.toString();
  }
}
