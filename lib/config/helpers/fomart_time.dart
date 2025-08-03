import 'package:intl/intl.dart';

class TimeFormatter {
  static String formatTime(String timeString) {
    DateTime time = DateTime.parse(timeString);
    return DateFormat.j().format(time);
  }

  static String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('d MMMM EEEE').format(date);
  }
}
