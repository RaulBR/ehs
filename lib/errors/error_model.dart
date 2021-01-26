class ErrorModel {
  Map<String, dynamic> errors;
  String name;

  ErrorModel.fromJson(Map<String, dynamic> parsedJson) {
    errors = parsedJson['errors'];
    name = parsedJson['name']?.toString();
  }
}

class GetException implements Exception {
  String _message;

  GetException([String message = 'Invalid value']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
