import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../resources/constants.dart';

class FileEntriesService {
  static Future<List<Map<String, dynamic>>> getFileEntries() async {
    var response =
        await http.get(WebServerUrls.fileEntriesFullPath);
    if (response.statusCode == 200) {
      return json.decode(response.body).toList();
    }
    return null;
  }

  static Future<Map<String, dynamic>> addFileEntry(
      Map<String, dynamic> fileEntryToAdd) async {
    var response = await http.post(
        WebServerUrls.fileEntriesFullPath,
        headers: jsonHeader,
        body: json.encode(fileEntryToAdd));
    if (response.statusCode == 201) {
      return json.decode(response.body)['fileEntry'];
    }
    return null;
  }

  static Future<bool> deleteFileEntry(String fileEntryId) async {
    var response = await http.delete(WebServerUrls.fileEntriesFullPath + '\\$fileEntryId');
    return response.statusCode == 200;
  }
}
