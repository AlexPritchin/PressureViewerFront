import '../../resources/constants.dart';

class User {
  String id;
  String email;
  String name;
  String password;
  String confirmPassword;

  User({this.id, this.email, this.name, this.password, this.confirmPassword});

  User.fromMap(Map<String, dynamic> userMap) {
    if(userMap[DBFileEntryTableFieldsNames.id] is String) {
      id = userMap[DBFileEntryTableFieldsNames.id];
    }
    if(userMap[DBUserTableFieldsNames.email] is String) {
      email = userMap[DBUserTableFieldsNames.email];
    }
    if(userMap[DBUserTableFieldsNames.name] is String) {
      name = userMap[DBUserTableFieldsNames.name];
    }
  }

  Map<String, dynamic> toMapForLogin() {
    return {
      'email': email,
      'password': password
    };
  }

  Map<String, dynamic> toMapForSignup() {
    var resultingMap = toMapForLogin();
    resultingMap['confirmPassword'] = confirmPassword;
    return resultingMap;
  }
}