import 'package:flutter/material.dart';

import '../models/auth/user.dart';
import '../services/web_services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  
  User currentUserData;

  Future<String> login(User userToLogin) async {
    var userMap = await AuthService.login(userToLogin.toMapForLogin());
    if (userMap != null && userMap['message'] != null) {
      return userMap['message'];
    }
    currentUserData = User.fromMap(userMap);
    return null;
  }

  Future<String> signup(User userToLogin) async {
    var userMap = await AuthService.signup(userToLogin.toMapForSignup());
    if (userMap != null && userMap['message'] != null) {
      return userMap['message'];
    }
    return null;
  }
}