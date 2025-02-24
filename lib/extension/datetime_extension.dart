import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  DateTime removeSubSecond() {
    return subtract(
        Duration(milliseconds: millisecond, microseconds: microsecond));
  }

  String formatAsYMD() {
    final dateFormat = DateFormat('yyyy/MM/dd');
    return dateFormat.format(this);
  }
}
