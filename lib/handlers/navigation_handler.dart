import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class NavigationHandler {
  ///Pushes `destinationRoute` route onto the stack
  Future<dynamic>? pushNamed(String destinationRoute, {dynamic arg});

  ///Pushes `destinationRoute` onto stack and removes stack items until
  ///`lastRoute` is hit
  Future<dynamic>? pushNamedAndRemoveUntil(
      String destinationRoute, String lastRoute,
      {dynamic arg});

  ///Pushes `destinationRoute` onto stack with replacement
  Future<dynamic>? pushReplacementNamed(String destinationRoute, {dynamic arg});

  ///Pushes `destinationRoute` after popping current route off stack
  Future<dynamic>? popAndPushNamed(String destinationRoute, {dynamic arg});

  ///Pops current route off stack
  void goBack();

  ///Pops routes on stack until `destinationRoute` is hit
  void popUntil([String? destinationRoute]);

  ///Exits app
  void exitApp();

  late GlobalKey<NavigatorState> navigatorKey;
}

/// Handles navigation
class NavigationHandlerImpl implements NavigationHandler {
  @override
  late GlobalKey<NavigatorState> navigatorKey;

  /// Constructs a NavigationHandler instance
  NavigationHandlerImpl({GlobalKey<NavigatorState>? navigatorKey}) {
    this.navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();
  }

  NavigatorState? get state => navigatorKey.currentState;

  @override
  void exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  void goBack() {
    state?.pop();
  }

  @override
  Future? popAndPushNamed(String destinationRoute, {arg}) {
    return state?.popAndPushNamed(destinationRoute, arguments: arg);
  }

  @override
  void popUntil([String? destinationRoute]) {
    if (state != null) {
      if (destinationRoute != null) {
        return state!.popUntil(ModalRoute.withName(destinationRoute));
      } else {
        return state!.popUntil((route) => true);
      }
    }
  }

  @override
  Future? pushNamed(String destinationRoute, {arg}) {
    return state?.pushNamed(destinationRoute, arguments: arg);
  }

  @override
  Future? pushNamedAndRemoveUntil(
    String destinationRoute,
    String lastRoute, {
    arg,
  }) {
    return state?.pushNamedAndRemoveUntil(
      destinationRoute,
      ModalRoute.withName(lastRoute),
      arguments: arg,
    );
  }

  @override
  Future? pushReplacementNamed(String destinationRoute, {arg}) {
    return state?.pushReplacementNamed(destinationRoute, arguments: arg);
  }
}
