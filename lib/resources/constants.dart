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
