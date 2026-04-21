import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_kalender/calendar_logic.dart';

class HistoryPage extends StatefulWidget {
  final CalendarLogic logic;

  const HistoryPage({super.key, required this.logic});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> events = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  @override
  void didUpdateWidget(covariant HistoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.logic.focusDate != widget.logic.focusDate) {
      loadEvents();
    }
  }

  Future<void> loadEvents() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final date = widget.logic.focusDate;
    final month = date.month;
    final day = date.day;

    final uri = Uri.parse(
      'https://api.wikimedia.org/feed/v1/wikipedia/de/onthisday/events/$month/$day',
    );

    try {
      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'flutter_kalender_app/1.0',
          'Accept': 'application/json',
        },
      );

      //200 = OK response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          events = data['events'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Serverantwort: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Fehler: $e';
        isLoading = false;
      });
    }
  }

  //Kleiner Infotext über den Tag
  String buildDateText() {
    final date = widget.logic.focusDate;
    final weekday = widget.logic.getWeekDayName();
    final monthName = widget.logic.getMonthName();

    return 'Es ist der ${date.day}. $monthName ${date.year}. '
        'Es ist ein $weekday.';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            buildDateText(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: loadEvents,
            child: const Text("Historische Ereignisse laden"),
          ),

          const SizedBox(height: 16),

          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (errorMessage != null)
            Text(errorMessage!, style: const TextStyle(color: Colors.red))
          else
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  final year = event['year'] ?? '';
                  final text = event['text'] ?? '-empty-';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$year',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(text),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
