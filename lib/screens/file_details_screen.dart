import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../resources/constants.dart';
import '../providers/main_provider.dart';
import '../widgets/file_details/chart_selected_item_details.dart';
import '../models/file_entry_measurement_item.dart';

class FileDetailsScreen extends StatefulWidget {
  @override
  _FileDetailsScreenState createState() => _FileDetailsScreenState();
}

class _FileDetailsScreenState extends State<FileDetailsScreen> {
  var chartDetails = ChartSelectedItemDetails();

  List<charts.Series<DateSeriesPressure, DateTime>> _createChartSeries(
      MainProvider provider) {
    final systolicPressureData = provider.currentOpenedCSVFileData
        .map((item) => new DateSeriesPressure(
            item.measurementDate, item.systoliticPressure))
        .toList();
    final diastolicPressureData = provider.currentOpenedCSVFileData
        .map((item) => new DateSeriesPressure(
            item.measurementDate, item.diastoliticPressure))
        .toList();
    return [
      new charts.Series<DateSeriesPressure, DateTime>(
        id: 'Systolic',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (DateSeriesPressure pressure, _) => pressure.date,
        measureFn: (DateSeriesPressure pressure, _) => pressure.pressureItem,
        data: systolicPressureData,
      ),
      new charts.Series<DateSeriesPressure, DateTime>(
        id: 'Diastolic',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DateSeriesPressure pressure, _) => pressure.date,
        measureFn: (DateSeriesPressure pressure, _) => pressure.pressureItem,
        data: diastolicPressureData,
      ),
    ];
  }

  _chartOnSelectionChanged(charts.SelectionModel model, MainProvider provider) {
    if (model.selectedDatum.length <= 0 ||
        model.selectedDatum.first == null ||
        model.selectedDatum.length == 1 ||
        model.selectedDatum[1] == null) {
      return;
    }

    var currentSelectedDate = model.selectedDatum.first.datum.date;
    int selectedHeartRate =
        provider.getHeartRateForItemInCurrentOpenedCSVFileData(
            byDate: currentSelectedDate);
    var currentSelectedMeasurementItem = FileEntryMeasurementItem(
      measurementDate: currentSelectedDate,
      systoliticPressure: model.selectedDatum.first.datum.pressureItem,
      diastoliticPressure: model.selectedDatum[1].datum.pressureItem,
      heartRate: selectedHeartRate,
    );
    chartDetails.currentState
        .changeDataWithItem(currentSelectedMeasurementItem);
  }

  @override
  Widget build(BuildContext context) {
    final fileEntryToOpenId = ModalRoute.of(context).settings.arguments;
    final mainProvid = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(ScreensTitles.fileDetailsScreenTitle),
      ),
      body: FutureBuilder(
        future: mainProvid.readFromCSVFileEntry(byId: fileEntryToOpenId),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : (snapshot.data != null && snapshot.data.length > 0)
                    ? /*Center(child: Text('Ready Success'))*/
                    Column(
                        children: <Widget>[
                          Text('File name: ' +
                              mainProvid
                                  .getFileEntry(byId: fileEntryToOpenId)
                                  .fileName),
                          Container(
                            height: 250,
                            child: new charts.TimeSeriesChart(
                              _createChartSeries(mainProvid),
                              animate: true,
                              behaviors: [
                                new charts.PanAndZoomBehavior(),
                              ],
                              selectionModels: [
                                new charts.SelectionModelConfig(
                                  type: charts.SelectionModelType.info,
                                  updatedListener: (selectionModel) {
                                    _chartOnSelectionChanged(
                                        selectionModel, mainProvid);
                                  },
                                )
                              ],
                            ),
                          ),
                          chartDetails,
                        ],
                      )
                    : Center(
                        child: Text(
                            'An error occured while parsing the file. Please try again or readd the file to the list. Probably your file is corrupted or has a wrong format.'),
                      ),
      ),
    );
  }
}

class DateSeriesPressure {
  final DateTime date;
  final int pressureItem;

  DateSeriesPressure(this.date, this.pressureItem);
}

// Text('${ModalRoute.of(context).settings.arguments}')
