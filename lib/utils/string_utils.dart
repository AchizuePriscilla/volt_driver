import 'package:timeago/timeago.dart' as timeago;

class StringUtils {
  static String getTimeAgo(DateTime date) {
    try {
      final now = DateTime.now();
      return timeago.format(
        DateTime.now().subtract(
          Duration(
            milliseconds: now.difference(date).inMilliseconds,
          ),
        ),
      );
    } catch (e) {
      return '';
    }
  }
}
