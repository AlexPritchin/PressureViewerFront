import 'package:flutter/material.dart';

import '../../models/auth/user.dart';
import '../../services/data_services/validation_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final User userData = User();

  tryLogin(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    var validationResult = _formKey.currentState.validate();
    if (validationResult) {
      _formKey.currentState.save();

    }
    setState(() {
      _isLoading = false;
    });
    if (validationResult) {
      // Navigator.of(context).pushNamed(routeName)
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: Card(
              elevation: 5.0,
              child: Container(
                width: deviceSize.width * 0.75,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: TextStyle(fontSize: 14)),
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _emailFocusNode,
                          validator: ValidationService.validateEmail,
                          onSaved: (value) {
                            userData.email = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 14)),
                          obscureText: true,
                          focusNode: _passwordFocusNode,
                          validator: ValidationService.validatePasswordNotEmpty,
                          onSaved: (value) {
                            userData.password = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _isLoading ?
                        RaisedButton(
                          color: Color.fromRGBO(21, 140, 123, 1),
                          onPressed: () {},
                          child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                        ) : 
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Don\'t have an account? Sign up',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                'Pressure viewer',
                style: TextStyle(
                  fontSize: 28,
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
          ),
        ],
      ),
    );
  }
}
