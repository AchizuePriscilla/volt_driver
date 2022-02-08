import 'dart:developer';
import 'package:volt_driver/models/api/login_request.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/utils.dart';

class LogInViewModel extends BaseViewModel {
  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }

  ///validates password text field
  String? validatePassword(String password) =>
      Validators.validatePassword(password);

  ///Makes a network call to log user in with [email] and [password]
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      if (loading) return;
      toggleLoading(true);

      var res = await authService.logIn(LoginRequest(
        email: email,
        password: password,
      ));

      if (res.success) {
        navigationHandler.pushReplacementNamed(ordersViewRoute);
        log(res.user!.email!);
      } else {
        //show error messagge
        log('An error occured');
        dialogHandler.showDialog(
            message: res.error!.message, contentType: DialogContentType.error);
        return;
      }
      toggleLoading(false);
    } catch (e) {
      AppLogger.logger.d(e);

      toggleLoading(false);
    }
  }
}
