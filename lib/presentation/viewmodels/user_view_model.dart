import 'dart:developer';

import 'package:location/location.dart';
import 'package:volt_driver/models/user_model.dart';
import 'package:volt_driver/presentation/viewmodels/base_view_model.dart';
import 'package:volt_driver/utils/utils.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserVM extends BaseViewModel {
  late UserModel _user;
  late UserModel _rxUser;
  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _currentlocationData;
  LocationData get currenLocation => _currentlocationData;
  set setCurrentLocation(LocationData locationData) {
    _currentlocationData = locationData;
  }

  String? get email {
    try {
      return _user.email!;
    } catch (e) {
      return '';
    }
  }

  String get password {
    try {
      return _user.password!;
    } catch (e) {
      return '';
    }
  }

  String? get id {
    try {
      return _user.id!;
    } catch (e) {
      return '';
    }
  }

  String? get timeOfCreation {
    try {
      return _user.timeOfCreation!;
    } catch (e) {
      return '';
    }
  }

  String get name {
    try {
      return _user.name!;
    } catch (e) {
      return '';
    }
  }

  String get address {
    try {
      return _user.address!;
    } catch (e) {
      return '';
    }
  }

  String get number {
    try {
      return _user.phoneNumber!;
    } catch (e) {
      return '';
    }
  }

  String get profilePic {
    try {
      return _user.avatar!;
    } catch (e) {
      return '';
    }
  }

  double? get latitude {
    try {
      return _rxUser.latitude;
    } catch (e) {
      return 0;
    }
  }

  double? get longitude {
    try {
      return _rxUser.longitude;
    } catch (e) {
      return 0;
    }
  }

  Future<void> checkTokenExpiry(Function handleExpiry) async {
    String? token = await localCache.getToken();
    bool isTokenExpired = JwtDecoder.isExpired(token!);
    if (isTokenExpired) {
      await localCache.deleteToken();
      handleExpiry();
      navigationHandler.pushNamed(logInViewRoute);
    }
  }

  Future<void> getUser() async {
    try {
      var user = await authService.getUser();
      _rxUser = user.user!;
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  ///Fetches user data from cache and parses it to a UserModel object
  Future<void> fetchUserDataFromCache() async {
    try {
      var userData = await localCache.getUserData();
      _user = UserModel.fromJson(userData);
      notifyListeners();
    } catch (e) {
      AppLogger.logger.d(e);
    }
  }

  void fetchLocation() async {
    try {
      await location.getLocation().then((onValue) {
        _currentlocationData = onValue;
        log("location of user: ${onValue.latitude}");
        log(onValue.latitude.toString() + "," + onValue.longitude.toString());
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> initLocation() async {
    log('Location running');
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    } else if (_serviceEnabled) {
      log('Service enabled');
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    } else if (_permissionGranted == PermissionStatus.granted) {
      log("Location of user: ");
      fetchLocation();
    }
  }
}
