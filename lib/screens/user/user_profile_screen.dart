import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../services/data_services/token_service.dart';
import '../../resources/constants.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 30.0, top: 20.0),
            child: Row(
              children: [
                Text(
                  'E-mail:',
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: FutureBuilder(
                    future: Provider.of<UserProvider>(context, listen: false)
                        .getCurrentUserEmail(),
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                snapshot.data ?? '',
                                style: TextStyle(fontSize: 16),
                              ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // FractionallySizedBox(
              //   widthFactor: 0.9,
              //   child: RaisedButton(
              //     color: Color.fromRGBO(21, 140, 123, 1),
              //     child: Text(
              //       'Change password',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //     onPressed: () {},
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: RaisedButton(
                    color: Color.fromRGBO(21, 140, 123, 1),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      TokenService.userToken = '';
                      TokenService.clearRefreshToken();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          ScreensRoutesNames.loginScreenRoute,
                          (route) => false);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
