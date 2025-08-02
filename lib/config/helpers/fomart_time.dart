import 'package:intl/intl.dart';

class TimeFormatter {
  static String formatTime(String timeString) {
    DateTime time = DateTime.parse(timeString);
    return DateFormat.j().format(time);
  }
}
