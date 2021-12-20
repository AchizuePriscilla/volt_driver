import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/utils.dart';

class SignUpViewModel extends BaseViewModel {
  void navigateToLogInView() {
    navigationHandler.pushNamed(logInViewRoute);
  }
}
