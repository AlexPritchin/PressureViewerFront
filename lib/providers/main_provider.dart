import 'dart:io';

import 'package:csv/csv_settings_autodetection.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:csv/csv.dart';

//import '../services/data_services/db_service.dart';
import '../services/web_serices/file_entries_service.dart';
import '../helpers/converter_helper.dart';
import '../resources/constants.dart';
import '../models/file_entry.dart';
import '../models/file_entry_measurement_item.dart';

class MainProvider with ChangeNotifier {
  List<FileEntry> _fileEntries = [];

  List<FileEntry> get fileEntries {
    return [..._fileEntries];
  }

  String _addedFileEntryId;

  List<FileEntryMeasurementItem> _currentOpenedCSVFileData = [];

  List<FileEntryMeasurementItem> get currentOpenedCSVFileData {
    return [..._currentOpenedCSVFileData];
  }

  SortOrderType currentSortOrderFileEntries = SortOrderType.Descending;

  int get addedFileEntryIndex {
    int fileEntryIndex =
        _fileEntries.indexWhere((element) => element.id == _addedFileEntryId);
    return fileEntryIndex == -1 ? 0 : fileEntryIndex;
  }

  FileEntry getFileEntry({String byId}) {
    return _fileEntries.firstWhere((element) => element.id == byId,
        orElse: () => null);
  }

  Future<List<FileEntry>> fetchFileEntries() async {
    _fileEntries = ConverterHelper.getListOfFileEntry(
      // fromListOfMaps: await DBService.selectAllFrom(
      //   table: DBTablesNames.fileEntries,
      //   sortOrder: sortOrderTypeToString(currentSortOrderFileEntries),
      // ),
      fromListOfMaps: await FileEntriesService.getFileEntries(),
    );
    _fileEntries.sort((itemA, itemB) =>
        currentSortOrderFileEntries == SortOrderType.Ascending
            ? itemA.dateModified.compareTo(itemB.dateModified)
            : -itemA.dateModified.compareTo(itemB.dateModified));
    return fileEntries;
  }

  bool checkFileNameIsInFileEntriesList({String byPath}) {
    final fileNameToCheck = path.basenameWithoutExtension(byPath);
    final fileEntryIfExistsIndex =
        _fileEntries.indexWhere((entry) => entry.fileName == fileNameToCheck);
    if (fileEntryIfExistsIndex == -1) {
      return false;
    }
    return true;
  }

  Future<bool> addFile({File fileToAdd}) async {
    final fileToAddName = path.basenameWithoutExtension(fileToAdd.path);
    DateTime fileToAddModifiedDate;
    try {
      fileToAddModifiedDate = await fileToAdd.lastModified();
    } catch (e) {
      try {
        fileToAddModifiedDate = await fileToAdd.lastAccessed();
      } catch (e) {
        fileToAddModifiedDate = DateTime.now();
      }
    }
    final newFilePath = await getFileInDocumentsFolderPath(fileToAddName);
    // _addedFileEntryId = await DBService.insert(
    //   table: DBTablesNames.fileEntries,
    //   data: FileEntry(
    //           dateModified: fileToAddModifiedDate, fileName: fileToAddName)
    //       .toMap(),
    // );
    var addedFileEntryMap = await FileEntriesService.addFileEntry(FileEntry(
              dateModified: fileToAddModifiedDate, fileName: fileToAddName)
          .toMap());
    if (addedFileEntryMap == null) {
      return false;
    }
    await fileToAdd.copy(newFilePath);
    _addedFileEntryId = addedFileEntryMap[DBFileEntryTableFieldsNames.id];
    return true;
  }

  Future<void> deleteFileEntry({String byId}) async {
    final fileEntryForDelete = _fileEntries
        .firstWhere((element) => element.id == byId, orElse: () => null);
    if (fileEntryForDelete != null) {
      final fileInDocumentsFolderForDeletePath =
          await getFileInDocumentsFolderPath(fileEntryForDelete.fileName);
      File fileInDocumentsFolderForDelete =
          File(fileInDocumentsFolderForDeletePath);
      if (fileInDocumentsFolderForDelete != null) {
        await fileInDocumentsFolderForDelete.delete();
        // await DBService.deleteFrom(
        //     table: DBTablesNames.fileEntries, byId: byId);
        await FileEntriesService.deleteFileEntry(fileEntryId: byId);
        _fileEntries.removeWhere((element) => element.id == byId);
      }
    }
    notifyListeners();
  }

  void sortFileEntries(SortOrderType sortOrder) {
    if (sortOrder != currentSortOrderFileEntries) {
      currentSortOrderFileEntries = sortOrder;
      notifyListeners();
    }
  }

  Future<List<FileEntryMeasurementItem>> readFromCSVFileEntry(
      {String byId}) async {
    String fileNameForRead = getFileEntry(byId: byId).fileName;
    final fileForReadPath = await getFileInDocumentsFolderPath(fileNameForRead);
    final fileToRead = File(fileForReadPath);
    final fileToReadContentsString = await fileToRead.readAsString();
    List<List<dynamic>> csvFileContentsList =
        const CsvToListConverter().convert(fileToReadContentsString, eol: '\n');
    csvFileContentsList = csvFileContentsList.skip(1).toList();
    _currentOpenedCSVFileData = csvFileContentsList.map((item) {
      var measurementDateStr = (item[0] as String).replaceAll('/', '-');
      var measurementDate = DateTime.parse(measurementDateStr);
      var systoliticPressure = int.tryParse(item[2]);
      var diastoliticPressure = int.tryParse(item[3]);
      var heartRate = int.tryParse(item[4]);
      return FileEntryMeasurementItem(
        measurementDate: measurementDate,
        systoliticPressure: systoliticPressure,
        diastoliticPressure: diastoliticPressure,
        heartRate: heartRate,
      );
    }).toList();

    return currentOpenedCSVFileData;
  }

  void clearCurrentCSVFileEntryDataList() {
    _currentOpenedCSVFileData = [];
  }

  int getHeartRateForItemInCurrentOpenedCSVFileData({DateTime byDate}) {
    var measurementItemForDate = _currentOpenedCSVFileData
        .firstWhere((element) => element.measurementDate == byDate);
    return measurementItemForDate.heartRate;
  }

  Future<String> getFileInDocumentsFolderPath(String fileName) async {
    final documentsDirectoryPath =
        await pathProvider.getApplicationDocumentsDirectory();
    return path.join(
        documentsDirectoryPath.path, '$fileName.$csvFileExtension');
  }
}
