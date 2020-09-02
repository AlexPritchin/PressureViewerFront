import 'package:flutter/material.dart';

import '../models/auth/user.dart';

class AuthProvider with ChangeNotifier {
  
  User currentUserData = User();

  Future<String> login(User userToLogin) {

  }

  Future<String> signup(User userToLogin) {
    
  }
}