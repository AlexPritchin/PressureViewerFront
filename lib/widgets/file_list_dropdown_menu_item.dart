import 'package:flutter/material.dart';

class FileListDropdownMenuItem extends StatelessWidget {
  final String labelText;
  final bool showSelectedMark;

  FileListDropdownMenuItem(this.labelText, this.showSelectedMark);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(labelText),
            if (showSelectedMark)
              Icon(Icons.check)
          ],
        ),
      );
  }
}
