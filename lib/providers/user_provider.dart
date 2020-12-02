import 'package:flutter/material.dart';

import '../models/auth/user.dart';
import '../services/web_services/user_service.dart';

class UserProvider with ChangeNotifier {
  
  User _currentUserData;

  Future<String> getCurrentUserEmail() async {
    if (_currentUserData == null) {
      await getCurrentUserData();
    }
    return _currentUserData.email ?? '';
  }

  Future<bool> getCurrentUserData() async {
    var userMap = await UserService.getCurrentUserData();
    if (userMap != null) {
      _currentUserData = User.fromMap(userMap);
      return true;
    }
    return false;
  }

}