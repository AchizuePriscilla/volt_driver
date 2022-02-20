import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volt_driver/models/navigation/oops_args.dart';
import 'package:volt_driver/models/navigation/pickup_details_args.dart';
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
        final order = settings.arguments;
        if (order != null && order is PickupDetailsArgs) {
          return _getPageRoute(PickupDetails(
            order: order.order,
          ));
        }
        return _getPageRoute(_errorPage(message: "Order parameter not passed"));
      case trackOrderViewRoute:
        final order = settings.arguments;
        if (order != null && order is PickupDetailsArgs) {
          return _getPageRoute(TrackOrderView(
            order: order.order,
          ));
        }
        return _getPageRoute(_errorPage(message: "Order parameter not passed"));
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
