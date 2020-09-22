import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../resources/constants.dart';
import '../../helpers/converter_helper.dart';
import './authorized_requests_service.dart';

class FileEntriesService {
  static Future<List<Map<String, dynamic>>> getFileEntries() async {
    var request = http.Request(HTTPMethodNames.getMethodName, Uri(path: WebServerUrls.fileEntriesFullPath));
    var response = await AuthorizedRequestsService.sendRequest(request);
    if (response.statusCode == 200) {
      List<dynamic> jsonBodyList = json.decode(response.body);
      var jsonBodyListOfMaps = jsonBodyList.map(ConverterHelper.getMapFromDynamic).toList();
      jsonBodyListOfMaps.removeWhere((item) => item == null);
      return jsonBodyListOfMaps;
    }
    return null;
  }

  static Future<Map<String, dynamic>> addFileEntry(
      Map<String, dynamic> fileEntryToAdd) async {
    var request = http.Request(HTTPMethodNames.post, Uri(path: WebServerUrls.fileEntriesFullPath));
    request.body = json.encode(fileEntryToAdd);
    var response = await AuthorizedRequestsService.sendRequest(request);
    if (response.statusCode == 201) {
      return json.decode(response.body)['fileEntry'];
    }
    return null;
  }

  static Future<bool> deleteFileEntry({String fileEntryId}) async {
    var request = http.Request(HTTPMethodNames.delete, Uri(path: WebServerUrls.fileEntriesFullPath + '/$fileEntryId'));
    var response = await AuthorizedRequestsService.sendRequest(request);
    return response.statusCode == 200;
  }
}
