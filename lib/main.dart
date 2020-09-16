import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './resources/constants.dart';
import './providers/main_provider.dart';
import './providers/auth_provider.dart';
import './screens/files/file_list_screen.dart';
import './screens/files/file_details_screen.dart';
import './screens/auth/login_screen.dart';
import './screens/auth/signup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: MainProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) => MaterialApp(
          title: ScreensTitles.fileListScreenTitle,
          theme: ThemeData(
            primaryColor: Color.fromRGBO(11, 130, 113, 1),
            textTheme: TextTheme(bodyText1: TextStyle(fontSize: 16)),
          ),
          // home: FileListScreen(),
          home: LoginScreen(),
          routes: {
            ScreensRoutesNames.fileListScreenRoute: (ctx) => FileListScreen(),
            ScreensRoutesNames.fileDetailsScreenRoute: (ctx) =>
                FileDetailsScreen(),
            ScreensRoutesNames.signUpScreenRoute: (ctx) => SignupScreen(),
          },
        ),
      ),
    );
  }
}
