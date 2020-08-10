const String dbName = 'pressure.db';

class DBTablesNames {
  static const String fileEntries = 'file_entries';
  static const String atmosphericPressures = 'atmosperic_pressures';
}

class DBFileEntryTableFieldsNames {
  static const String id = 'id';
  static const String dateModified = 'date_modified';
  static const String fileName = 'file_name';
}

class DBAtmPressuresTableFieldsNames {
  static const String date = 'date';
  static const String pressure = 'pressure';
}

class ScreensTitles {
  static const String fileListScreenTitle = 'Pressure viewer';
  static const String fileDetailsScreenTitle = 'File details';
}

class ScreensRoutesNames {
  static const String fileDetailsScreenRoute = '/file-details';
}

const String csvFileExtension = 'csv';

enum SortOrderType {
  Ascending,
  Descending,
}

String sortOrderTypeToString(SortOrderType sortOrder) {
  switch (sortOrder) {
    case SortOrderType.Ascending:
      return 'ASC';
    case SortOrderType.Descending:
      return 'DESC';
    default:
      return 'DESC';
  }
}

class Errors {
  static const String fileDetailsParsingError = 'An error occured while parsing the file. Please try again or readd the file to the list. Probably your file is corrupted or has a wrong format.';
}

const String fileDetailsFileNameTitle = 'File name: ';

class FileDetailsChartDetailsTitles {
  static const String dateTitle = 'Date: ';
  static const String systoliticPressureTitle = 'Systolitic pressure:';
  static const String diastoliticPressureTitle = 'Diastolitic pressure:';
  static const String heartRateTitle = 'Heart rate:';
}