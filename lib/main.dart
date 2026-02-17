import 'package:flutter/material.dart';
import 'package:flutter_kalender/calendar_logic.dart';

void main() {
  runApp(const KalenderApp());
}

class KalenderApp extends StatefulWidget {
  const KalenderApp({super.key});

  @override
  State<KalenderApp> createState() => _KalenderAppState();
}

class _KalenderAppState extends State<KalenderApp> {
final CalendarLogic logic = CalendarLogic();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debug Banner entfernen
      home: Scaffold(
        appBar: AppBar(
          title: const Text("KalenderApp"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 3,
          shadowColor: Colors.black, 
        ),
        body: Center(
          child: Column(
            children: [
              // Monat Jahr und buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        debugPrint("Vorheriger Monat");
                      },
                    ),
                    Text(
                      "Februar 2026",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        debugPrint("Nächster Monat");
                      },
                    ),
                  ],
                ),
              ),

              // 2. Wochentage
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"]
                    .map((day) => Text(day, style: TextStyle(fontWeight: FontWeight.bold)))
                    .toList(),
              ),

              // 3. Kalender Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, // 7 Tage pro Woche
                  ),
                  itemCount: 42, // Anzahl der anzeigbaren Tage 
                  itemBuilder: (context, index) { //-----------------------------------------------------------------------------------------
                    int dayText = 0;
                    int daysPrevMonth = logic.getDaysInPrevMonth();
                    int daysInMonth = logic.getDaysInMonth();
                    int weekDay = logic.getWeekDay();
                    int monthIndex = (index + 1) - (weekDay - 1);
                    bool otherMonth = false;
                    if(index +1  < weekDay ){
                      dayText = daysPrevMonth - ((weekDay-1) - (index+1));
                      otherMonth = true;
                    }else if(monthIndex <= daysInMonth){
                      dayText = monthIndex;
                      otherMonth = false;
                    }else{
                      dayText = (index + 1) - daysInMonth - (weekDay-1);
                      otherMonth = true;
                    }
                    

                    return Card(
                      child: InkWell( // Feld klickbar
                        onTap: () {
                          debugPrint("Tag ${index + 1} gedrückt");
                        },
                        child: Center(
                          child: Text("${dayText}",style:TextStyle(color: otherMonth? Colors.red:Colors.black)), //Farbentschiedung
                          
                        ),
                      ),
                    );
                    //-------------------------------------------------------------------------------------------------------------------------
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}