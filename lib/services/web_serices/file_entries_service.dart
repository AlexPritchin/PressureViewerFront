import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../resources/constants.dart';

class FileEntriesService {

  static Future<List<Map<String, dynamic>>> getFileEntries() async {
    var response = await http.get(serverMainUrl + WebServerUrls.fileEntriesPath);
    if (response.statusCode == 200) {
      return json.decode(response.body).toList();
    }
    return [];
  }
  
}