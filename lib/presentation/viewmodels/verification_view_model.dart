import 'dart:async';
import 'dart:developer';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';

class VerificationViewModel extends BaseViewModel {
  static const int minutes = 1;
  int _minutes = minutes;
  int _seconds = 30;

  ///Returns formatted time string
  String get getTime =>
      '${_minutes.toString().padLeft(2, '0')} : ${_seconds.toString().padLeft(2, '0')}';

  ///Returns [true] if countdown is active, otherwise [false]
  bool get active => _minutes < minutes;

  ///Resets timer to 0[MINUTES]: 00 (e.g 05 : 00 if MINUTES is 5)
  void resetTimer() {
    _seconds = 30;
    _minutes = minutes;
    notifyListeners();
  }

  ///Returns timer object and handles countdown logic
  Timer? _handleTimer() {
    try {
      resetTimer();
      Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_seconds == 0) {
          _seconds = 59;
          _minutes -= 1;
        } else {
          _seconds -= 1;
        }

        notifyListeners();
      });

      return timer;
    } catch (e) {
      log(e.toString());
    }
  }

  ///Starts countdown and stop/reset stop time
  void startTimer() {
    Timer? timer = _handleTimer();
    if (timer != null) {
      Future.delayed(Duration(minutes: _minutes)).then((value) {
        timer.cancel();
        resetTimer();
      });
    }
  }



  void navigateToRoute(String route) {
    navigationHandler.pushNamed(route);
  }
}
