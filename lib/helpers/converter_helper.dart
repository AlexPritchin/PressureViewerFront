import '../models/file_entry.dart';

class ConverterHelper {
  
  static List<FileEntry> getListOfFileEntry({List<Map<String, dynamic>> fromListOfMaps}){
    List<FileEntry> fileEntryList = [];
    fromListOfMaps.forEach((element) {
      fileEntryList.add(FileEntry.fromMap(element));
    });
    return fileEntryList;
  }

}