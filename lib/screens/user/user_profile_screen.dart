import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

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
              FractionallySizedBox(
                widthFactor: 0.9,
                child: RaisedButton(
                  child: Text('Change password'),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: RaisedButton(
                    child: Text('Logout'),
                    onPressed: () {},
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
