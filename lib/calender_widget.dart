import 'package:flutter/material.dart';
import 'package:flutter_kalender/calendar_logic.dart';

class CalendarBody extends StatefulWidget {
  final CalendarLogic logic;
  const CalendarBody({super.key, required this.logic});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      widget.logic.jumpMonth(-1);
                    });
                  },
                ),
                Text(
                  "${widget.logic.getMonthName()} ${widget.logic.focusDate.year}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      widget.logic.jumpMonth(1);
                    });
                  },
                ),
              ],
            ),
          ),

          //Oberste Überschriftreihe für die Tage zeichnen
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"]
                .map(
                  (day) => Text(
                    day,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
                .toList(),
          ),

          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), //Scrollen innherlab des Widgets deaktiviert, da es schon im singlechildscrollview ist
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              int dayText = 0;
              int daysPrevMonth = widget.logic.getDaysInPrevMonth();
              int daysInMonth = widget.logic.getDaysInMonth();
              int weekDay = widget.logic.getWeekDayOfFirstMonthDay();
              int monthIndex = (index + 1) - (weekDay - 1);

              bool otherMonth = false;
              bool prevMonthDay = false;
              bool nextMonthDay = false;

              //Tage des vorherigen, dann aktuellen und dann des nächsten Monats berechnen
              if (index + 1 < weekDay) {
                dayText = daysPrevMonth - ((weekDay - 1) - (index + 1));
                otherMonth = true;
                prevMonthDay = true;
              } else if (monthIndex <= daysInMonth) {
                dayText = monthIndex;
              } else {
                dayText = (index + 1) - daysInMonth - (weekDay - 1);
                otherMonth = true;
                nextMonthDay = true;
              }

              return Card(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      int year = widget.logic.focusDate.year;
                      int month = widget.logic.focusDate.month;

                      if (prevMonthDay) {
                        month--;
                        if (month < 1) {
                          month = 12;
                          year--;
                        }
                      } else if (nextMonthDay) {
                        month++;
                        if (month > 12) {
                          month = 1;
                          year++;
                        }
                      }
                      //Datum mit Monat und Jahr aktualisieren, falls Datum außerhalb des fokussierten Monats angeklickt wurde
                      widget.logic.setDate(year, month, dayText);
                    });
                  },
                  child: Center(
                    child: Text(
                      "$dayText",
                      style: TextStyle(
                        color: otherMonth ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
