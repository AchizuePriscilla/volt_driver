import 'package:connectivity/connectivity.dart';

abstract class ConnectivityService {
  Future<bool> hasInternet();
}

class ConnectivityServiceImpl implements ConnectivityService {
  //this checks if user has active internet connection before attempting network call
  @override
  Future<bool> hasInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile
        ? true
        : connectivityResult == ConnectivityResult.wifi
            ? true
            : false;
  }
}
