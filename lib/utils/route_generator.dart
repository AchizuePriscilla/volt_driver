import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt_driver/models/navigation/oops_args.dart';
import 'package:volt_driver/presentation/views/views.dart';
import 'package:volt_driver/utils/utils.dart';

class RouteGenerator {
  ///Generates routes, extracts and passes navigation arguments.
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenViewRoute:
        return _getPageRoute(const SplashScreenView());
      case onboardingViewRoute:
        return _getPageRoute(const OnboardingView());
      
     
      case logInViewRoute:
        return _getPageRoute(const LogInView());
      case resetPasswordViewRoute:
        return _getPageRoute(const ResetPasswordView());
      case forgotPasswordViewRoute:
        return _getPageRoute(const ForgotPasswordView());
      case ordersViewRoute:
        return _getPageRoute(const OrdersView());
      case pickupDetailsViewRoute:
        return _getPageRoute(const PickupDetails());
      case trackOrderViewRoute:
        return _getPageRoute(const TrackOrderView());
      case oopsViewRoute:
        final message = settings.arguments;
        if (message != null && message is OopsArgs) {
          return _getPageRoute(Oops(message: message.message));
        }

        return _getPageRoute(
            _errorPage(message: "Message parameter not passed"));
      default:
        return _getPageRoute(_errorPage());
    }
  }

  //Wraps widget with a CupertinoPageRoute and adds route settings
  static CupertinoPageRoute _getPageRoute(
    Widget child, [
    String? routeName,
    dynamic args,
  ]) =>
      CupertinoPageRoute(
        builder: (context) => child,
        settings: RouteSettings(
          name: routeName,
          arguments: args,
        ),
      );

  ///Error page shown when app attempts navigating to an unknown route
  static Widget _errorPage({String message = "Error! Page not found"}) =>
      Scaffold(
        appBar: AppBar(
            title: const Text(
          'Page not found',
          style: TextStyle(color: Colors.red),
        )),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
}
