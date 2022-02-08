import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/constants.dart';

class SplashScreenVM extends BaseViewModel {
  Future<void> handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) async {
      await localCache.getToken().then(
        (token) async {
          //check if user is logged in
          if (token != null && token.isNotEmpty) {
            //if user is logged in,
            navigationHandler.pushReplacementNamed(homeViewRoute);
          } else {
            //#beginning of user not logged in flow
            //if user is not logged in, check if user has been onboarded
            bool hasBeenOnboarded =
                localCache.getFromLocalCache(onboardingDone) != null;

            if (hasBeenOnboarded) {
              navigationHandler.pushReplacementNamed(logInViewRoute);
            } else {
              //if user has not been onboarded, navigate to OnboardingView
              navigationHandler.pushReplacementNamed(onboardingViewRoute);
            }
            //#end of user not logged in flow
          }
        },
      );
    });
  }
}
