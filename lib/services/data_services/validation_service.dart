class ValidationService {

  static final alphanumericRegExp = RegExp(r'^[a-zA-Z0-9]+$');
  
  static String validateEmail(String email) {
    if (email.isEmpty || !email.contains('@')) {
      return 'Invalid e-mail';
    }
    return null;
  }

  static String validatePasswordNotEmpty(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  static String validatePasswordFull(String password) {
    if (password.isEmpty || password.length < 6 || !alphanumericRegExp.hasMatch(password)) {
      return 'Password cannot be empty. Password must be not less than 6 characters. Password can contain only numbers and letters.';
    }
    return null;
  }
}