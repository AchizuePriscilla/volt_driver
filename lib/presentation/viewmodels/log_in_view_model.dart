import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';

class LogInViewModel extends BaseViewModel {
  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

}
