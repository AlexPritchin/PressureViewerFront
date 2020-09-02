import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../resources/constants.dart';
import '../../helpers/converter_helper.dart';

class AuthService {
  
  static Future<Map<String, dynamic>> login(Map<String, dynamic> userCredentials) async {
    var response = await http.post(WebServerUrls.loginFullPath,
        headers: jsonHeader, body: json.encode(userCredentials));
    if (response.statusCode == 200) {
      dynamic jsonBodyObject = json.decode(response.body);
      var jsonBodyMap = ConverterHelper.getMapFromDynamic(jsonBodyObject);
      return jsonBodyMap;
    }
    return null;
  }

}