import 'dart:convert';
import 'dart:io';
import 'package:bookyourdriveing/services/loacal_storage.dart';
import 'package:http/http.dart';

class HttpService {
  final localstorageService = LocalStorageService();
  String _url = 'http://192.168.0.4:4000';
  bool isDayTime;
  String _token;

  Future<dynamic> deleteRequest({String endpint}) async {
    try {
      dynamic headders = getHeaders();
      Response response = await delete('$_url$endpint', headers: headders);
      return handlleDeleteResponce(response: response);
    } catch (e) {
      print('e: $e');
      // throw (jsonDecode(e));
    }
  }

  Future<dynamic> postRequest(
      {String endpint, Map<String, dynamic> jsonValue, bool hasHeadder}) async {
    hasHeadder = hasHeadder == null ? false : hasHeadder;
    dynamic headders = hasHeadder ? await getHeaders() : null;
    print('endpint: $endpint  token $_token');
    Response response =
        await post('$_url$endpint', body: jsonValue, headers: headders);
    return handlleResponce(response: response);
  }

  Future<String> getRequest({String endpint, bool hasHeadder}) async {
    hasHeadder = hasHeadder == null ? false : hasHeadder;
    dynamic headders = hasHeadder ? await getHeaders() : null;
    Response response = await get('$_url$endpint', headers: headders);
    return handlleResponce(response: response);
  }

  String handlleResponce({Response response}) {
    int statusCode = response.statusCode;
    print(statusCode);
    switch (statusCode) {
      case 200:
        return response.body.isNotEmpty ? response.body : null;
        break;
      case 400:
        throw response.body.isNotEmpty
            ? json.decode(response.body)['message']
            : 'no errorMessage';
        break;
      case 401:
        throw 'Not alowed';
        break;
      case 500:
        throw '500';
        break;
      default:
        return null;
    }
  }

  String handlleDeleteResponce({Response response}) {
    if (response.body.isNotEmpty) {
      Map<String, dynamic> data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      print('codeeee: $statusCode');
      if (statusCode == 200) {
        return 'succes';
      }

      if (statusCode == 400) {
        throw data['message'];
      }
      if (statusCode == 401) {
        throw 'Not alowed';
      }
    }
    return null;
  }

  Future<Map<String, String>> getHeaders() async {
    if (_token == null) {
      _token = await localstorageService.getToken();
    }
    return {
      // HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "$_token",
    };
  }
}
