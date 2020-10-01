import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text(
          'PW',
          style: TextStyle(
            fontSize: 144,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(-3, -1),
                blurRadius: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
