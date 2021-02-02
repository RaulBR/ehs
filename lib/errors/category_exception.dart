class CategoryException implements Exception {
  String _message;

  CategoryException([String message = 'Invalid value']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}

class CategoryTypeException implements Exception {
  String _message;

  CategoryTypeException([String message = 'Invalid value']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
