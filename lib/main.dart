import 'package:flutter/material.dart';
import 'package:flutter_kalender/calendar_logic.dart';
import 'package:flutter_kalender/calender_widget.dart';

import 'package:flutter_kalender/history_widget.dart';

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
  int _selectedIndex = 0; // Kalender als Standardseite

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CalendarBody(logic: logic),
      HistoryPage(logic: logic),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Kalender"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(187, 49, 162, 255),
        ),
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.calendar_month),
                  label: Text("Kalender"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history_edu),
                  label: Text("Historische Ereignisse"),
                ),
              ],
            ),
            const VerticalDivider(thickness: 3, width: 1),
            Expanded(child: pages[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
