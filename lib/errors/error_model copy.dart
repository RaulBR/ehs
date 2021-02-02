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
