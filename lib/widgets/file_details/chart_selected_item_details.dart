import 'package:flutter/material.dart';

import '../../models/file_entry_measurement_item.dart';

class ChartSelectedItemDetails extends StatefulWidget {
  _ChartSelectedItemDetailsState currentState;

  @override
  _ChartSelectedItemDetailsState createState() =>
      _ChartSelectedItemDetailsState();
}

class _ChartSelectedItemDetailsState extends State<ChartSelectedItemDetails> {
  var _currentSelectedDateString = '';
  var _currentSelectedSystoliticPressure = '';
  var _currentSelectedDiastoliticPressure = '';
  var _currentSelectedHeartRate = '';

  changeDataWithItem(FileEntryMeasurementItem measurementItem) {
    setState(() {
      _currentSelectedDateString = measurementItem.measurementDateString;
      _currentSelectedSystoliticPressure =
          measurementItem.systoliticPressureString;
      _currentSelectedDiastoliticPressure =
          measurementItem.diastoliticPressureString;
      _currentSelectedHeartRate = measurementItem.heartRateString;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyleForThisWidget = TextStyle(fontSize: 16);
    widget.currentState = this;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Date: ' + _currentSelectedDateString,
            style: textStyleForThisWidget,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Systolitic pressure:',
                    style: textStyleForThisWidget,
                  ),
                ),
                Expanded(
                  child: Text(
                    _currentSelectedSystoliticPressure,
                    style: textStyleForThisWidget,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Diastolitic pressure:',
                    style: textStyleForThisWidget,
                  ),
                ),
                Expanded(
                  child: Text(
                    _currentSelectedDiastoliticPressure,
                    style: textStyleForThisWidget,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Heart rate:',
                    style: textStyleForThisWidget,
                  ),
                ),
                Expanded(
                  child: Text(
                    _currentSelectedHeartRate,
                    style: textStyleForThisWidget,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
