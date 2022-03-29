import 'package:url_launcher/url_launcher.dart';

abstract class UrlLaunchHandler {
  Future<Object?> callPhone(String phone);
  // Future<Object?> launchUrl(String url);
}

class UrlLaunchException implements Exception {
  final String message;
  const UrlLaunchException(this.message);

  @override
  String toString() {
    return "Exception: $message";
  }
}

class UrlLaunchHandlerImpl implements UrlLaunchHandler {
  @override
  Future<Object?> callPhone(String phone) async {
    final url = "tel://$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      return UrlLaunchException("Couldn't call $phone");
    }
    return null;
  }

  // @override
  // Future<Object?> launchUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     return UrlLaunchException("Couldn't process link");
  //   }
  // }
}
