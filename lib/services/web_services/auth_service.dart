import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../resources/constants.dart';
import '../../helpers/converter_helper.dart';
import './authorized_requests_service.dart';

class AuthService {
  
  static Future<Map<String, dynamic>> login(Map<String, dynamic> userCredentials) async {
    var response = await http.post(WebServerUrls.loginFullPath,
        headers: HTTPRequestHeaders.singleJsonContentHeader, body: json.encode(userCredentials));
    dynamic jsonBodyObject = json.decode(response.body);
    if (response.statusCode == 200) {
      return ConverterHelper.getMapFromDynamic(jsonBodyObject['user']);
    }
    return { 'message':  jsonBodyObject['message'] };
  }

  static Future<Map<String, dynamic>> signup(Map<String, dynamic> userCredentials) async {
    var response = await http.put(WebServerUrls.signupFullPath,
        headers: HTTPRequestHeaders.singleJsonContentHeader, body: json.encode(userCredentials));
    dynamic jsonBodyObject = json.decode(response.body);
    if (response.statusCode == 201) {
      return null;
    }
    return { 'message':  jsonBodyObject['message'] };
  }

  static Future<bool> tryReLogin() async {
    final refreshTokenResponse = await AuthorizedRequestsService.sendRefreshToken();
    if (refreshTokenResponse != null && refreshTokenResponse.statusCode == 200) {
      return true;
    }
    return false;
  }

}