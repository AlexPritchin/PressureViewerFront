import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

import '../../models/auth/user.dart';
import '../../services/data_services/validation_service.dart';
import '../../providers/auth_provider.dart';
import '../../helpers/alerts_helper.dart';
import '../../resources/constants.dart';

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
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    var networkConnectionExists = await Connectivity().checkConnectivity();
    if (networkConnectionExists == ConnectivityResult.none) {
      AlertsHelper.showSnackBarError(context, Errors.noNetworkError);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    var validationResult = _formKey.currentState.validate();
    var loginResult = '';
    if (validationResult) {
      _formKey.currentState.save();
      loginResult = await Provider.of<AuthProvider>(context, listen: false)
          .login(userData);
    }
    setState(() {
      _isLoading = false;
    });
    if (validationResult && loginResult == null) {
      Navigator.of(context).pushNamed(
                ScreensRoutesNames.fileListScreenRoute,);
    } else if (validationResult && loginResult != null) {
      AlertsHelper.showSnackBarError(context, loginResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      _emailFocusNode.unfocus();
      _passwordFocusNode.unfocus();
    }
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
                        _isLoading
                            ? CircularProgressIndicator()
                            : RaisedButton(
                                color: Color.fromRGBO(21, 140, 123, 1),
                                onPressed: () {
                                  tryLogin(context);
                                },
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          onPressed: () {
                            _emailFocusNode.unfocus();
                            _passwordFocusNode.unfocus();
                            Navigator.of(context).pushNamed(
                ScreensRoutesNames.signUpScreenRoute,);
                          },
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
          if (MediaQuery.of(context).viewInsets.bottom == 0) Container(
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
