import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './resources/constants.dart';
import './providers/main_provider.dart';
import './screens/file_list_screen.dart';
import './screens/file_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MainProvider(),
      child: MaterialApp(
        title: ScreensTitles.fileListScreenTitle,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(11, 130, 113, 1),
          textTheme: TextTheme(bodyText1: TextStyle(fontSize: 16)),
        ),
        home: FileListScreen(),
        routes: {
          ScreensRoutesNames.fileDetailsScreenRoute: (ctx) => FileDetailsScreen(),
        },
      ),
    );
  }
}
