import 'package:flutter/material.dart';

import '../models/auth/user.dart';
import '../services/web_services/auth_service.dart';
import '../services/data_services/token_service.dart';

class AuthProvider with ChangeNotifier {
  
  User _currentUserData;

  String get currentUserEmail {
    return _currentUserData.email ?? '';
  }

  Future<String> login(User userToLogin) async {
    var userMap = await AuthService.login(userToLogin.toMapForLogin());
    if (userMap != null && userMap['message'] != null) {
      return userMap['message'];
    }
    if (userMap['token'] == null || userMap['refreshToken'] == null) {
      return 'An error occured. Please try again.';
    }
    final refreshTokenSet = await TokenService.setRefreshToken(userMap['refreshToken']);
    if (!refreshTokenSet) {
      return 'An error occured. Please try again.';
    }
    TokenService.userToken = userMap['token'];
    _currentUserData = User.fromMap(userMap);
    return null;
  }

  Future<String> signup(User userToLogin) async {
    var userMap = await AuthService.signup(userToLogin.toMapForSignup());
    if (userMap != null && userMap['message'] != null) {
      return userMap['message'];
    }
    return null;
  }

  Future<bool> tryReLogin() async {
    final reloginResult = await AuthService.tryReLogin();
    if (reloginResult) {
      var userMap = await AuthService.getCurrentUserData();
      _currentUserData = User.fromMap(userMap);
    }
    return reloginResult;
  }
}