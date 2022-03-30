import 'package:flutter/material.dart';
import 'package:volt_driver/data/local/local.dart';
import 'package:volt_driver/data/remote/auth_apis/auth_service.dart';
import 'package:volt_driver/data/remote/direction_apis/direction_service.dart';
import 'package:volt_driver/data/remote/order_apis/order_service.dart';
import 'package:volt_driver/handlers/handlers.dart';
import 'package:volt_driver/utils/locator.dart';

///Base view model with shared dependencies injected.
///All view models must extends this class.
class BaseViewModel extends ChangeNotifier {
  late NavigationHandler navigationHandler;
  late DialogHandler dialogHandler;
  late LocalCache localCache;
  late AuthService authService;
  late OrderService orderService;
  late DirectionService directionService;
  late UrlLaunchHandler urlLaunchHandler;

  BaseViewModel(
      {NavigationHandler? navigationHandler,
      DialogHandler? dialogHandler,
      UrlLaunchHandler? urlLaunchHandler,
      LocalCache? localCache,
      AuthService? authService,
      DirectionService? directionService,
      OrderService? orderService}) {
    this.navigationHandler = navigationHandler ?? locator();
    this.dialogHandler = dialogHandler ?? locator();
    this.urlLaunchHandler = urlLaunchHandler ?? locator();
    this.localCache = localCache ?? locator();
    this.authService = authService ?? locator();
    this.orderService = orderService ?? locator();
    this.directionService = directionService ?? locator();
  }
  bool _loading = false;
  bool get loading => _loading;

  void toggleLoading(bool val) {
    _loading = val;
    notifyListeners();
  }
}
