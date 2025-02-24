extension DatetimeExtension on DateTime {
  DateTime removeSubSecond() {
    return subtract(
        Duration(milliseconds: millisecond, microseconds: microsecond));
  }
}
