import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../resources/constants.dart';
import '../../helpers/converter_helper.dart';
import './authorized_requests_service.dart';

class UserService {
  
  static Future<Map<String, dynamic>> getCurrentUserData() async {
    var request = http.Request(HTTPMethodNames.getMethodName, Uri.tryParse(WebServerUrls.userDataFullPath));
    var response = await AuthorizedRequestsService.sendRequest(request);
    if (response.statusCode == 200) {
      dynamic jsonBodyObject = json.decode(response.body);
      return ConverterHelper.getMapFromDynamic(jsonBodyObject);
    }
    return null;
  }

}