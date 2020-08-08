import 'package:flutter/material.dart';

import '../../models/file_entry_measurement_item.dart';

class ChartSelectedItemDetails extends StatefulWidget {
  _ChartSelectedItemDetailsState currentState;

  @override
  _ChartSelectedItemDetailsState createState() => _ChartSelectedItemDetailsState();
}

class _ChartSelectedItemDetailsState extends State<ChartSelectedItemDetails> {
  var _currentSelectedDateString = '';
  var _currentSelectedSystoliticPressure = '';
  var _currentSelectedDiastoliticPressure = '';
  var _currentSelectedHeartRate = '';

  changeDataWithItem(FileEntryMeasurementItem measurementItem) {
    setState(() {
      _currentSelectedDateString = measurementItem.measurementDateString;
      _currentSelectedSystoliticPressure = measurementItem.systoliticPressureString;
      _currentSelectedDiastoliticPressure = measurementItem.diastoliticPressureString;
      _currentSelectedHeartRate = measurementItem.heartRateString;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.currentState = this;
    return Column(
      children: <Widget>[
        Text('Date: ' + _currentSelectedDateString),
        Row(
          children: <Widget>[
            Text('Systolitic pressure:'),
            Text(_currentSelectedSystoliticPressure),
          ],
        ),
        Row(
          children: <Widget>[
            Text('Diastolitic pressure:'),
            Text(_currentSelectedDiastoliticPressure),
          ],
        ),
        Row(
          children: <Widget>[
            Text('Heart rate:'),
            Text(_currentSelectedHeartRate),
          ],
        ),
      ],
    );
  }
}