import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/main_provider.dart';

class ChartSelectedItemDetailsMeasurementItem extends StatelessWidget {
  final TextStyle currentTextStyle;
  final String itemLabel;
  final String itemValue;
  final DateTime itemDate;

  ChartSelectedItemDetailsMeasurementItem({
    @required this.currentTextStyle,
    this.itemLabel,
    this.itemValue,
    this.itemDate,
  });

  @override
  Widget build(BuildContext context) {
    final mainProvid = Provider.of<MainProvider>(context);
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
          if (itemDate == null)
            Expanded(
              child: Text(
                itemValue,
                style: currentTextStyle,
              ),
            ),
          if (itemDate != null)
            FutureBuilder(
              future: mainProvid.getAtmosphericPressureForDate(itemDate),
              builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Expanded(
                                              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          CircularProgressIndicator()
                        ],),
                      ) 
                      : Expanded(
                          child: Text(
                            snapshot.data,
                            style: currentTextStyle,
                          ),
                        ),
            )
        ],
      ),
    );
  }
}
