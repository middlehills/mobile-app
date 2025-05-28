import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // static const String userEmailKey = 'userEmailKey';
  // static const String loginCheckKey = 'loginCheckKey';
  static const String accessTokenKey = 'accessTokenKey';
  static const String refreshTokenKey = 'refreshTokenKey';
  static const authStorage = FlutterSecureStorage();

  // store  access token
  static Future<bool> storeAccessStoken(String accessToken) async {
    try {
      await authStorage.write(key: accessTokenKey, value: accessToken);
      return true;
    } catch (e) {
      return false;
    }
  }

  // get user id
  static Future<String?> getAccessToken() async {
    try {
      String? thisAccessToken = await authStorage.read(key: accessTokenKey);
      return thisAccessToken;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> clearAccessToken() async {
    try {
      await authStorage.delete(key: accessTokenKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  // store  access token
  static Future<bool> storeRefreshToken(String refreshToken) async {
    try {
      await authStorage.write(key: refreshTokenKey, value: refreshToken);
      return true;
    } catch (e) {
      return false;
    }
  }

  // get user id
  static Future<String?> getRefreshToken() async {
    try {
      String? thisRefreshToken = await authStorage.read(key: refreshTokenKey);
      return thisRefreshToken;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> clearRefreshToken() async {
    try {
      await authStorage.delete(key: refreshTokenKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  // clear storage
  static Future<bool> clear() async {
    try {
      await authStorage.deleteAll();
      return true;
    } catch (e) {
      return false;
    }
  }
}
