import 'package:flutter/material.dart';
import 'package:pressure_viewer/widgets/file_details/chart_selected_item_details_measurement_item.dart';

import '../../models/files/file_entry_measurement_item.dart';
import '../../resources/constants.dart';
import 'chart_selected_item_details_measurement_item.dart';

class ChartSelectedItemDetails extends StatefulWidget {
  _ChartSelectedItemDetailsState currentState;
  FileEntryMeasurementItem initialMeasurementItem;

  @override
  _ChartSelectedItemDetailsState createState() =>
      _ChartSelectedItemDetailsState();
}

class _ChartSelectedItemDetailsState extends State<ChartSelectedItemDetails> {
  final textStyleForThisWidget = TextStyle(fontSize: 16);
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
    widget.currentState = this;
    if (widget.initialMeasurementItem != null) {
      if (_currentSelectedDateString == '')
        _currentSelectedDateString =
            widget.initialMeasurementItem.measurementDateString;
      if (_currentSelectedSystoliticPressure == '')
        _currentSelectedSystoliticPressure =
            widget.initialMeasurementItem.systoliticPressureString;
      if (_currentSelectedDiastoliticPressure == '')
        _currentSelectedDiastoliticPressure =
            widget.initialMeasurementItem.diastoliticPressureString;
      if (_currentSelectedHeartRate == '')
        _currentSelectedHeartRate =
            widget.initialMeasurementItem.heartRateString;
      widget.initialMeasurementItem = null;
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            FileDetailsChartDetailsTitles.dateTitle +
                _currentSelectedDateString,
            style: textStyleForThisWidget,
          ),
          ChartSelectedItemDetailsMeasurementItem(
            currentTextStyle: textStyleForThisWidget,
            itemLabel: FileDetailsChartDetailsTitles.systoliticPressureTitle,
            itemValue: _currentSelectedSystoliticPressure,
          ),
          ChartSelectedItemDetailsMeasurementItem(
            currentTextStyle: textStyleForThisWidget,
            itemLabel: FileDetailsChartDetailsTitles.diastoliticPressureTitle,
            itemValue: _currentSelectedDiastoliticPressure,
          ),
          ChartSelectedItemDetailsMeasurementItem(
            currentTextStyle: textStyleForThisWidget,
            itemLabel: FileDetailsChartDetailsTitles.heartRateTitle,
            itemValue: _currentSelectedHeartRate,
          ),
        ],
      ),
    );
  }
}
