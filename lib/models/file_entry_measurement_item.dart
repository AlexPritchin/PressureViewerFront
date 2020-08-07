class FileEntryMeasurementItem {
  final DateTime measurementDate;
  final int systoliticPressure;
  final int diastoliticPressure;
  final int heartRate;

  FileEntryMeasurementItem({this.measurementDate, this.systoliticPressure, this.diastoliticPressure, this.heartRate});

  String get dateString => measurementDate.toString();
  String get systoliticPressureString => systoliticPressure.toString();
  String get diastoliticPressureString => diastoliticPressure.toString();
  String get heartRateString => heartRate.toString();
}