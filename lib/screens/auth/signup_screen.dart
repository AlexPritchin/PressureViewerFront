import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

import '../../models/auth/user.dart';
import '../../services/data_services/validation_service.dart';
import '../../helpers/alerts_helper.dart';
import '../../resources/constants.dart';
import '../../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final User userData = User();

  trySignup(BuildContext context) async {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _confirmPasswordFocusNode.unfocus();
    var networkConnectionExists = await Connectivity().checkConnectivity();
    if (networkConnectionExists == ConnectivityResult.none) {
      AlertsHelper.showSnackBarError(context, Errors.noNetworkError);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    var validationResult = _formKey.currentState.validate();
    var signupResult = '';
    if (validationResult) {
      _formKey.currentState.save();
      signupResult = await Provider.of<AuthProvider>(context, listen: false)
          .signup(userData);
    }
    setState(() {
      _isLoading = false;
    });
    if (validationResult && signupResult == null) {
      Navigator.of(context).pop(true);
    } else if (validationResult && signupResult != null) {
      AlertsHelper.showSnackBarError(context, signupResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Builder(builder: (BuildContext ctx) {
        return Stack(
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
                            validator:
                                ValidationService.validatePasswordNotEmpty,
                            onSaved: (value) {
                              userData.password = value;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Confirm password',
                                labelStyle: TextStyle(fontSize: 14)),
                            obscureText: true,
                            focusNode: _confirmPasswordFocusNode,
                            validator:
                                ValidationService.validatePasswordNotEmpty,
                            onSaved: (value) {
                              userData.confirmPassword = value;
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
                                    trySignup(ctx);
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              'Already have an account? Sign in',
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
            if (MediaQuery.of(context).viewInsets.bottom == 0)
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
        );
      }),
    );
  }
}
