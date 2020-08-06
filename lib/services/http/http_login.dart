import 'dart:convert';
import 'package:ehsfocus/models/user.model.dart';
import 'package:ehsfocus/services/http/http.dart';

class HttpLoginService extends HttpService {
  Future<dynamic> login(User user) async {
    return userPstWrapper(url: '/login', user: user);
  }

  Future<dynamic> signUp(User user) async {
    if (user == null) {
      return;
    }
    return userPstWrapper(url: '/user', user: user);
  }

  Future<dynamic> signOut() async {
    return postRequest(endpint: '/user/logout', hasHeadder: true);
  }

  Future<dynamic> isMe() {
    return userPstWrapper(url: '/me', hasHeadder: true);
  }

  Future<dynamic> userPstWrapper(
      {String url, User user, bool hasHeadder}) async {
    hasHeadder = hasHeadder == null ? false : hasHeadder;
    Map<String, dynamic> dataIn;
    if (user != null) {
      dataIn = user.toJson();
    }
    String data = await postRequest(
        endpint: url, jsonValue: dataIn, hasHeadder: hasHeadder);
    if (data == null) {
      return null;
    }
    return User.fromJson(json.decode(data));
  }
}
