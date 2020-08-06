import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../resources/constants.dart';
import '../providers/main_provider.dart';

class FileDetailsScreen extends StatefulWidget {
  @override
  _FileDetailsScreenState createState() => _FileDetailsScreenState();
}

class _FileDetailsScreenState extends State<FileDetailsScreen> {
  

  List<charts.Series<DateSeriesPressure, DateTime>> _createChartSeries(
      MainProvider provider) {
    final systolicPressureData = provider.currentOpenedCSVFileData
        .map((item) => new DateSeriesPressure(item[0], item[1]))
        .toList();
    final diastolicPressureData = provider.currentOpenedCSVFileData
        .map((item) => new DateSeriesPressure(item[0], item[2]))
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

  // _chartOnSelectionChanged(charts.SelectionModel model) {
  //   if (model.selectedDatum.length > 0) {
  //     print(model.selectedDatum.first.datum.pressureItem);
  //     print(model.selectedDatum.first.datum.date);
  //     print(model.selectedDatum[1].datum.pressureItem);
  //   }
  // }

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
                          Text('File name: ' + mainProvid.getFileEntry(byId: fileEntryToOpenId).fileName),
                          Container(
                            height: 250,
                            child: new charts.TimeSeriesChart(
                              _createChartSeries(mainProvid),
                              animate: true,
                              behaviors: [
                                new charts.PanAndZoomBehavior(),
                              ],
                              // selectionModels: [
                              //   new charts.SelectionModelConfig(
                              //     type: charts.SelectionModelType.info,
                              //     updatedListener: _chartOnSelectionChanged,
                              //   )
                              // ],
                            ),
                          ),
                          // Row(children: <Widget>[
                          //   Text('Systolitic pressure:')
                          // ],)
                        ],
                      )
                    : Center(child: Text('An error occured while parsing the file. Please try again or readd the file to the list. Probably your file is corrupted or has a wrong format.')),
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
