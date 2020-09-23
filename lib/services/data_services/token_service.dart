import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart';

class TokenService {
  static String userToken = '';

  static String get userTokenStringForHeader {
    return 'bearer ' + userToken;
  }

  static Future<bool> setRefreshToken(String refreshToken) async {
    final secretKey = Key.fromUtf8('someverysecretsk');
    final initVector = IV.fromUtf8('someverysecretiv');
    final encrypter = Encrypter(AES(secretKey));
    final encryptedRefreshToken = encrypter.encrypt(refreshToken, iv: initVector);
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setString('userRefreshToken', encryptedRefreshToken.base64);
  }

  static Future<String> getRefreshToken() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final base64RefreshToken = sharedPrefs.getString('userRefreshToken');
    final secretKey = Key.fromUtf8('someverysecretsk');
    final initVector = IV.fromUtf8('someverysecretiv');
    final encrypter = Encrypter(AES(secretKey));
    final encryptedRefreshToken = Encrypted.fromBase64(base64RefreshToken);
    return encrypter.decrypt(encryptedRefreshToken, iv: initVector);
  }

  static Future<bool> clearRefreshToken() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.remove('userRefreshToken');
  }
}