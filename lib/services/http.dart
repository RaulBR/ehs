import 'dart:convert';
import 'package:bookyourdriveing/models/user.model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class HttpService {
  String location; // location name for ui
  String time; // the time in that location
  String flag; // url to flag
  String url;
  bool isDayTime;

  Future<void> getTime() async {
    // request
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/');
      Map data = jsonDecode(response.body);
      String dateTime = data['datetime'];
      String ofSet = data['utc_offset'].substring(1, 3);

      // create a data
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(ofSet)));

      // set time property
      isDayTime = now.hour > 6 && now.hour < 20;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'now data';
    }
  }

  Future<dynamic> login(User user) async {
    return postTeamplate('/api/user/login', user);
  }

  Future<dynamic> signUp(User user) async {
    return postTeamplate('/api/user', user);
  }
  
  Future<dynamic> signOut() async {
      return postTeamplate('/api/user/logout', null);
  }
  Future<dynamic> postTeamplate(endpint, User user) async {
    print( user.toJson());
        try {
      Response response =
          await post('http://192.168.0.4:4000$endpint', body: user.toJson());
      Map data = jsonDecode(response.body);
      return data;
    } catch (e) {
       print('e: $e');
      return e;
    }
  }
}
