import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../resources/constants.dart';
import '../providers/main_provider.dart';

class FileDetailsScreen extends StatefulWidget {
  @override
  _FileDetailsScreenState createState() => _FileDetailsScreenState();
}

class _FileDetailsScreenState extends State<FileDetailsScreen> {
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
                    ? Center(child: Text('Ready Error'))
                    : Center(child: Text('Ready Success')),
      ),
    );
  }
}

// Text('${ModalRoute.of(context).settings.arguments}')
