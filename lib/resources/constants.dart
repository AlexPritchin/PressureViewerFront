const String dbName = 'pressure.db';

class DBTablesNames {
  static const String fileEntries = 'file_entries';
  static const String atmosphericPressures = 'atmosperic_pressures';
}

class DBFileEntryTableFieldsNames {
  static const String id = 'id';
  static const String dateModified = 'dateModified';
  static const String fileName = 'fileName';
}

class DBUserTableFieldsNames {
  static const String email = 'email';
  static const String name = 'name';
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
  static const String fileListScreenRoute = '/file-list';
  static const String fileDetailsScreenRoute = '/file-details';
  static const String signUpScreenRoute = '/signup';
  static const String userProfileScreenRoute = '/user-profile';
  static const String loginScreenRoute = '/login';
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
  static const String noNetworkError = 'No internet connection available';
  static const String fileListFileAlreadyExists = 'The file with such name was already added to the list.';
  static const String fileDetailsParsingError = 'An error occured while parsing the file. Please try again or readd the file to the list. Probably your file is corrupted or has a wrong format.';
  static const String unknownError = 'An error occured. Please try again.';
}

const String fileDetailsFileNameTitle = 'File name: ';

class FileDetailsChartDetailsTitles {
  static const String dateTitle = 'Date: ';
  static const String systoliticPressureTitle = 'Systolitic pressure:';
  static const String diastoliticPressureTitle = 'Diastolitic pressure:';
  static const String heartRateTitle = 'Heart rate:';
  static const String atmosphericPressureTitle = 'Atmospheric pressure:';
}

class HTTPRequestHeaders {
  static const String contentHeaderName = 'Content-Type';
  static const String contentHeaderValueJson = 'application/json';
  static const String authorizationHeaderName = 'Authorization';
  static Map<String, String> get singleJsonContentHeader {
    return {contentHeaderName: contentHeaderValueJson};
  }
}

const serverMainUrl = 'http://10.0.2.2:8000';

class WebServerUrls {
  static const String authPath = '/auth';
  static const String userPath = '/user';
  static const String signupPath = '/signup';
  static const String loginPath = '/signin';
  static const String refreshTokenPath = '/refreshToken';
  static const String dataPath = '/data';
  static const String signupFullPath = serverMainUrl + authPath + signupPath;
  static const String loginFullPath = serverMainUrl + authPath + loginPath;
  static const String refreshTokenFullPath = serverMainUrl + authPath + refreshTokenPath;
  static const String userDataFullPath = serverMainUrl + userPath + dataPath;
  static const String filesPath = '/files';
  static const String fileEntriesPath = '/file-entries';
  static const String fileEntriesFullPath = serverMainUrl + filesPath + fileEntriesPath;
}

const weatherApiUrl = 'https://community-open-weather-map.p.rapidapi.com/onecall/timemachine';

class Messages {
  static const String fileListNoFilesMessage = 'No files found. Press "+" button to add a statistics file.';
  static const String confirmDeleteFileMessage = 'Do you want to delete file entry from the app? This operation will not delete file from your device.';
}

class AlertTitles {
  static const String error = 'Error';
  static const String areYouSure = 'Are you sure?';
}

class ButtonsTitles {
  static const String ok = 'OK';
  static const String yes = 'Yes';
  static const String no = 'No';
}

class DropdownMenuTitles {
  static const String sort = 'Sort by date';
  static const String ascending = 'Ascending';
  static const String descending = 'Descending';
}

class HTTPMethodNames {
  static const String getMethodName = 'GET';
  static const String post = 'POST';
  static const String delete = 'DELETE';
}