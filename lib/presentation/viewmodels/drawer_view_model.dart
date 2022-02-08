import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';

class DrawerVM extends BaseViewModel {
  ///Navigates to `route`
  Future<void> navigateToRoute(String route,
      {bool signOut = false, dynamic arg}) async {
    if (signOut) {
      await localCache.deleteToken();
    }
    navigationHandler.pushNamed(route, arg: arg);
  }
}
