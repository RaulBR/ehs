import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
// Create storage
  final storage = new FlutterSecureStorage();

// Write value
  Future setToken(token) async {
    await storage.write(key: 'jwt', value: token);
  }

  Future getToken() async {
    return await storage.read(key: 'jwt');
  }
    Future removeToken() async {
    return await storage.delete(key: 'jwt');
  }


  _readWithKey(key) {
    return storage.read(key: key);
  }

  _setWithKey({String key, String value}) {
    return storage.write(key: key, value: value);
  }
}
