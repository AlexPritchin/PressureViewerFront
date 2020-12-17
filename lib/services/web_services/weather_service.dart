import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../resources/constants.dart';
import '../../helpers/converter_helper.dart';
import './authorized_requests_service.dart';

class WeatherService {
  
  static const String rapidApiHeaderKeyTitle = 'x-rapidapi-key';
  static const String rapidApiHeaderHostTitle = 'x-rapidapi-host';
  static const String rapidApiHeaderUseQueryStringTitle = 'useQueryString';

  static Future<Map<String, dynamic>> getWeatherDataForUnixTime(int timeForWeatherToGet) async {
    Map<String, String> requestParams = {
      'lat': '49.05',
      'lon': '33.24',
      'dt': timeForWeatherToGet.toString()
    };
    String requestParamsString = Uri(queryParameters: requestParams).query;
    var request = http.Request(HTTPMethodNames.getMethodName, Uri.tryParse(weatherApiUrl + '?' + requestParamsString));
    request.headers[rapidApiHeaderKeyTitle] = '22f4508defmsh37fe116b051cd25p12c24ejsn8cca1ffc2723';
    request.headers[rapidApiHeaderHostTitle] = 'community-open-weather-map.p.rapidapi.com';
    request.headers[rapidApiHeaderUseQueryStringTitle] = 'true';
    
    var rawResponse = await request.send();
    var rawResponseBody = await rawResponse.stream.bytesToString();
    var response = http.Response(rawResponseBody, rawResponse.statusCode);
    if (response.statusCode == 200) {
      dynamic jsonBodyObject = json.decode(response.body);
      return ConverterHelper.getMapFromDynamic(jsonBodyObject);
    }
    return null;
  }

}