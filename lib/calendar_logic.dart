class CalendarLogic {
  var focusDate = DateTime.now();

  final List<String> weekDays = ["Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag","Sonntag"];

  int getDaysInMonth(){
    return DateTime(focusDate.year,focusDate.month +1,0).day;
  }

  int getDaysInPrevMonth(){
     return DateTime(focusDate.year,focusDate.month,0).day;
  }

  int getWeekDay(){
    return DateTime(focusDate.year,focusDate.month,1).weekday;
  }

  void setDate(int year,int month,int day){
    focusDate = DateTime(year,month,day);
  }

  void jumpMonth(int months){

    
    setDate(focusDate.year, focusDate.month + months, focusDate.day);
  }
}
