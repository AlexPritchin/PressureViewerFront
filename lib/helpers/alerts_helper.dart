import 'package:flutter/material.dart';

class AlertsHelper {

  static showSnackBarError(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            text,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
  }
  
}