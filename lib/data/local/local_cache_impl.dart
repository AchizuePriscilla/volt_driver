import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt_driver/data/local/local_cache.dart';
import 'package:volt_driver/data/local/secure_storage.dart';
// import 'package:volt_driver/models/user_model.dart';
import 'package:volt_driver/utils/logger.dart';

class LocalCacheImpl implements LocalCache {
  static const userToken = 'userTokenId';
  static const user = "currentUser";

  late SecureStorage storage;
  late SharedPreferences sharedPreferences;

  LocalCacheImpl({
    required this.storage,
    required this.sharedPreferences,
  });

  @override
  Future<void> deleteToken() async {
    try {
      await storage.delete(userToken);
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  @override
  Object? getFromLocalCache(String key) {
    try {
      return sharedPreferences.get(key);
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await storage.read(userToken);
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  @override
  Future<void> removeFromLocalCache(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await storage.write(key: userToken, value: token);
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  @override
  Future<void> saveToLocalCache({required String key, required value}) async {
    AppLogger.logger.d('Data being saved: key: $key, value: $value');
    if (value is String) {
      await sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    }
    if (value is Map) {
      await sharedPreferences.setString(key, json.encode(value));
    }
  }

  @override
  Future<void> cacheUserData({required String value}) async {
    await saveToLocalCache(key: user, value: value);
  }

  @override
  Future<void> deleteUserData() async {
    await removeFromLocalCache(user);
  }

  @override
  Future<Map<String, dynamic>> getUserData() async {
    var res = getFromLocalCache(user) as String? ?? '{}';
    return Map<String, dynamic>.from(json.decode(res));
  }

  // @override
  // Future<void> updateUserData({String? name,
  //     String? phoneNumber,
  //     String? address,
  //     int? latitude,
  //     int? longitude,
  //     String? avatar}) async {
  //    try {
  //     final userDataJson = await getUserData();

  //     final user = UserModel.fromJson(userDataJson).copyWith(
  //      name: name,
  //      phoneNumber: phoneNumber,
  //      address: address,
  //      latitude: latitude,
  //      longitude: longitude,
  //      avatar: avatar
  //     );

  //     await cacheUserData(value: json.encode(user.toJson()));
  //   } catch (e) {
  //     AppLogger.logger.d(e);
  //   }
  // }
  }

