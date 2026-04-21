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

  //Gibt die Anzahl der Tage im aktuelle fokkussierten Monat zurück
  int getDaysInMonth() {
    return DateTime(focusDate.year, focusDate.month + 1, 0).day;
  }

  //Gibt zurück ie viele Tage der vorherige Monat hatte
  int getDaysInPrevMonth() {
    return DateTime(focusDate.year, focusDate.month, 0).day;
  }

  //Gibt als Nummer zurück, welcher Wochentag der 1te des Monats ist für die Gridberechnung
  int getWeekDayOfFirstMonthDay() {
    return DateTime(focusDate.year, focusDate.month, 1).weekday;
  }

  //Deutscher Name des Wochentags
  String getWeekDayName() {
    return weekDays[focusDate.weekday - 1];
  }

  //ändert das fokussierte Datum
  void setDate(int year, int month, int day) {
    focusDate = DateTime(year, month, day);
  }

  //springt x Monate vor oder zurück - funktioniert grad nur für x < 12
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
}
