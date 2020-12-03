import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import './resources/constants.dart';
import './providers/main_provider.dart';
import './providers/auth_provider.dart';
import './providers/user_provider.dart';
import './screens/files/file_list_screen.dart';
import './screens/files/file_details_screen.dart';
import './screens/auth/login_screen.dart';
import './screens/auth/signup_screen.dart';
import './screens/user/user_profile_screen.dart';
import './screens/common/spalsh_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: MainProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) => MaterialApp(
          title: ScreensTitles.fileListScreenTitle,
          theme: ThemeData(
            primaryColor: Color.fromRGBO(11, 130, 113, 1),
            textTheme: TextTheme(bodyText1: TextStyle(fontSize: 16)),
          ),
          // home: FileListScreen(),
          // home: LoginScreen(),
          home: FutureBuilder(
              future: Provider.of<AuthProvider>(context, listen: false)
                  .tryReLogin(),
              builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? SplashScreen()
                      : (snapshot.data ? FileListScreen() : LoginScreen())),
          routes: {
            ScreensRoutesNames.fileListScreenRoute: (ctx) => FileListScreen(),
            ScreensRoutesNames.fileDetailsScreenRoute: (ctx) =>
                FileDetailsScreen(),
            ScreensRoutesNames.signUpScreenRoute: (ctx) => SignupScreen(),
            ScreensRoutesNames.userProfileScreenRoute: (ctx) =>
                UserProfileScreen(),
            ScreensRoutesNames.loginScreenRoute: (ctx) =>
                LoginScreen(),
          },
        ),
      ),
    );
  }
}
