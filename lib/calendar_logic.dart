class CalendarLogic {
  var focusDate = DateTime.now();

  final List<String> weekDays = ["Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag","Sonntag"];
  final List<String> monthNames = ["Januar","Februar","März","Aprill","Mai","Juni","Juli","August","Septmeber","Oktober","November","Dezember"];

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
    

    if((focusDate.month + months) < 0){
     setDate(focusDate.year -1, 12, focusDate.day);
    }else  if((focusDate.month + months) > 12){
      setDate(focusDate.year +1, 1, focusDate.day);
    }else{
      setDate(focusDate.year,focusDate.month+months, focusDate.day);
    }
   
    

    
  }

  String getMonthName(){
    return monthNames[focusDate.month -1];
  }
}
