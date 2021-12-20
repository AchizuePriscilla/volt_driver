import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/constants.dart';

class SetPhoneNumberVM extends BaseViewModel {
  void navigateToPhoneNumberVerification() {
    navigationHandler.pushNamed(verificationViewRoute);
  }
}
