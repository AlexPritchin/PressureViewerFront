import 'package:flutter/material.dart';

class ChartSelectedItemDetailsMeasurementItem extends StatelessWidget {
  final TextStyle currentTextStyle;
  final String itemLabel;
  final String itemValue;

  ChartSelectedItemDetailsMeasurementItem({
    @required this.currentTextStyle,
    this.itemLabel,
    this.itemValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Text(
              itemLabel,
              style: currentTextStyle,
            ),
          ),
          Expanded(
            child: Text(
              itemValue,
              style: currentTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
