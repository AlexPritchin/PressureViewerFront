import 'package:flutter/foundation.dart';

import '../../resources/constants.dart';

class FileEntry {
  String id;
  DateTime dateModified;
  String fileName;

  FileEntry({this.id, @required this.dateModified, @required this.fileName});

  FileEntry.fromMap(Map<String, dynamic> entryMap) {
    if (entryMap[DBFileEntryTableFieldsNames.id] is String) {
      id = entryMap[DBFileEntryTableFieldsNames.id];
    }
    if (entryMap[DBFileEntryTableFieldsNames.dateModified] is int) {
      dateModified = DateTime.fromMillisecondsSinceEpoch(entryMap[DBFileEntryTableFieldsNames.dateModified]);
    }
    if (entryMap[DBFileEntryTableFieldsNames.fileName] is String) {
      fileName = entryMap[DBFileEntryTableFieldsNames.fileName];
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapRepresentation = {
      DBFileEntryTableFieldsNames.dateModified : dateModified.millisecondsSinceEpoch,
      DBFileEntryTableFieldsNames.fileName : fileName,
    };
    if (id != null) {
      mapRepresentation[DBFileEntryTableFieldsNames.id] = id;
    }
    return mapRepresentation;
  }

}