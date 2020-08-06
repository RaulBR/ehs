import 'dart:convert';
import 'dart:io';
import 'package:ehsfocus/services/loacal_storage.dart';
import 'package:http/http.dart';

class HttpService {
  final localstorageService = LocalStorageService();
  // String _url = 'https://ehs-back.herokuapp.com';
  String _url = 'http://192.168.0.9:3000/api';
  bool isDayTime;
  String _token;

  Future<dynamic> deleteRequest({String endpint, String id}) async {
    try {
      dynamic headders = await getHeaders();
      await delete('$_url$endpint?id=$id', headers: headders);
      return 'success'; //handlleDeleteResponce(response: response);
    } catch (e) {
      print('e: $e');
      return 'delete error';
    }
  }

  Future<dynamic> postRequest(
      {String endpint, dynamic jsonValue, bool hasHeadder}) async {
    hasHeadder = hasHeadder == null ? false : hasHeadder;
    dynamic headders = hasHeadder ? await getHeaders() : null;

    Response response =
        await post('$_url$endpint', body: jsonValue, headers: headders);
    return handlleResponce(response: response);
  }

  Future<String> getRequest(
      {String endpint, String id, bool hasHeadder}) async {
    hasHeadder = hasHeadder == null ? false : hasHeadder;
    dynamic headders = hasHeadder ? await getHeaders() : null;
    Response response = await get('$_url$endpint', headers: headders);
    return handlleResponce(response: response);
  }

  String handlleResponce({Response response}) {
    int statusCode = response.statusCode;
    switch (statusCode) {
      case 201:
      case 200:
        return response.body.isNotEmpty ? response.body : null;
        break;
      case 400:
        throw response.body.isNotEmpty
            ? json.decode(response.body)['message']
            : StatusList[Status.noErrorMessage];
        break;
      case 401:
        throw StatusList[Status.notAllowed];
        break;
      case 500:
        throw '500';
        break;
      default:
        return null;
    }
  }

  String handlleDeleteResponce({Response response}) {
    int statusCode = response.statusCode;
    switch (statusCode) {
      case 201:
      case 200:
        return StatusList[Status.success];
        break;
      case 400:
        throw response.body.isNotEmpty
            ? json.decode(response.body)['message']
            : StatusList[Status.noErrorMessage];
        break;
      case 401:
        throw StatusList[Status.notAllowed];
        break;
      case 500:
        throw StatusList[Status.serverError];
        break;
      default:
        return null;
    }
  }

  Future<Map<String, String>> getHeaders() async {
    // if (_token == null) {
    _token = await localstorageService.getToken();
    // }
    return {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $_token",
    };
  }
}

enum Status { success, notAllowed, noErrorMessage, serverError, error }

const Map<Status, String> StatusList = {
  Status.success: "Success",
  Status.notAllowed: 'Not alowed',
  Status.noErrorMessage: 'No errorMessage',
  Status.serverError: ' Server error'
};
const Map<Status, int> HttpStatus = {
  Status.success: 200,
  Status.notAllowed: 401,
  Status.error: 400,
  Status.serverError: 500
};
