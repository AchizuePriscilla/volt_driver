import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/constants.dart';

class SplashScreenVM extends BaseViewModel {
  Future<void> handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) async {
      navigationHandler.pushReplacementNamed(onboardingViewRoute);
    });
  }
}
