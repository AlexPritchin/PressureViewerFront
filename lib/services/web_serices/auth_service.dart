import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../resources/constants.dart';
import '../../helpers/converter_helper.dart';

class AuthService {
  
  static Future<Map<String, dynamic>> login(Map<String, dynamic> userCredentials) async {
    var response = await http.post(WebServerUrls.loginFullPath,
        headers: jsonHeader, body: json.encode(userCredentials));
    dynamic jsonBodyObject = json.decode(response.body);
    if (response.statusCode == 200) {
      return ConverterHelper.getMapFromDynamic(jsonBodyObject['user']);
    }
    return { 'message':  jsonBodyObject['message'] };
  }

  static Future<bool> signup(Map<String, dynamic> userCredentials) async {
    var response = await http.put(WebServerUrls.signupFullPath,
        headers: jsonHeader, body: json.encode(userCredentials));
    return response.statusCode == 200;
  }

}