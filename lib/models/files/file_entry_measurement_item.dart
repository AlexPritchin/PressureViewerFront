class FileEntryMeasurementItem {
  final DateTime measurementDate;
  final int systoliticPressure;
  final int diastoliticPressure;
  final int heartRate;

  FileEntryMeasurementItem({this.measurementDate, this.systoliticPressure, this.diastoliticPressure, this.heartRate});

  String get measurementDateString {
    var dateFullString = measurementDate.toString();
    return dateFullString.substring(0, dateFullString.length-7);
  } 
  String get systoliticPressureString => systoliticPressure.toString();
  String get diastoliticPressureString => diastoliticPressure.toString();
  String get heartRateString => heartRate.toString();
}