import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../resources/constants.dart';
import '../../services/data_services/token_service.dart';

class AuthorizedRequestsService {

  static Future<http.StreamedResponse> sendRefreshToken() async {
    final http.Request refreshTokenRequest = http.Request(HTTPMethodNames.post, Uri.tryParse(WebServerUrls.refreshTokenFullPath));
    refreshTokenRequest.headers[HTTPRequestHeaders.contentHeaderName] = HTTPRequestHeaders.contentHeaderValueJson;
    final currentRefreshToken = await TokenService.getRefreshToken();
    refreshTokenRequest.body = json.encode({
      'refreshToken': currentRefreshToken
    });
    var response = await refreshTokenRequest.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final newToken = json.decode(responseBody)['token'];
      TokenService.userToken = newToken;
    }
    return response;
  }
  
  static Future<http.Response> sendRequest(http.Request requestToSend) async {
    requestToSend.headers[HTTPRequestHeaders.contentHeaderName] = HTTPRequestHeaders.contentHeaderValueJson;
    requestToSend.headers[HTTPRequestHeaders.authorizationHeaderName] = TokenService.userTokenStringForHeader;
    var mainRequestResponse = await requestToSend.send();
    var resultResponseBody = await mainRequestResponse.stream.bytesToString();
    if (mainRequestResponse.statusCode == 401) {
      final refreshTokenRequestResponse = await sendRefreshToken();
      if (refreshTokenRequestResponse.statusCode != 200) {
        resultResponseBody = await refreshTokenRequestResponse.stream.bytesToString();
        return http.Response(resultResponseBody, refreshTokenRequestResponse.statusCode);
      }
      requestToSend.headers[HTTPRequestHeaders.authorizationHeaderName] = TokenService.userTokenStringForHeader;
      mainRequestResponse = await requestToSend.send();
      resultResponseBody = await mainRequestResponse.stream.bytesToString();
    }
    return http.Response(resultResponseBody, mainRequestResponse.statusCode);
  }

}