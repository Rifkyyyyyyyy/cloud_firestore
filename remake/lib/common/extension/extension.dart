extension DayOfWeek on DateTime {
  static List<String> day = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];

  String get dayOfWeek {
    return DayOfWeek.day[weekday - 1];
  }
}
