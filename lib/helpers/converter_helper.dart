import '../models/file_entry.dart';

class ConverterHelper {
  static List<FileEntry> getListOfFileEntry(
      {List<Map<String, dynamic>> fromListOfMaps}) {
    List<FileEntry> fileEntryList = [];
    fromListOfMaps.forEach((element) {
      fileEntryList.add(FileEntry.fromMap(element));
    });
    return fileEntryList;
  }

  static Map<String, dynamic> getMapFromDynamic(dynamic object) {
    try {
      return object as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
}
