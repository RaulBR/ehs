class EmployeeException implements Exception {
  String _message;

  EmployeeException([String message = 'Invalid value']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
