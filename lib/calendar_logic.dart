class CalendarLogic {
  DateTime focusDate = DateTime.now();
  static const daysPerWeek = 7;
  static const totalCells = 42;

  final List<String> weekDays = [
    "Montag",
    "Dienstag",
    "Mittwoch",
    "Donnerstag",
    "Freitag",
    "Samstag",
    "Sonntag",
  ];
  final List<String> monthNames = [
    "Januar",
    "Februar",
    "März",
    "April",
    "Mai",
    "Juni",
    "Juli",
    "August",
    "September",
    "Oktober",
    "November",
    "Dezember",
  ];

  int getDaysInMonth() {
    return DateTime(focusDate.year, focusDate.month + 1, 0).day;
  }

  int getDaysInPrevMonth() {
    return DateTime(focusDate.year, focusDate.month, 0).day;
  }

  int getWeekDay() {
    return DateTime(focusDate.year, focusDate.month, 1).weekday;
  }

  String getWeekDayName() {
    return weekDays[focusDate.weekday - 1];
  }

  void setDate(int year, int month, int day) {
    focusDate = DateTime(year, month, day);
  }

  void jumpMonth(int months) {
    int newYear = focusDate.year;
    int newMonth = focusDate.month + months;

    if (newMonth < 1) {
      newMonth = 12;
      newYear--;
    } else if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    }

    setDate(newYear, newMonth, 1);
  }

  String getMonthName() {
    return monthNames[focusDate.month - 1];
  }

  String getDayText() {
    String text =
        'Heute ist ${getWeekDayName()} der ${focusDate.day} ${getMonthName()}';

    return text;
  }
}
