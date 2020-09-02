class User {
  String id;
  String email;
  String name;
  String password;
  String confirmPassword;

  User([this.id, this.email, this.name, this.password, this.confirmPassword]);

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