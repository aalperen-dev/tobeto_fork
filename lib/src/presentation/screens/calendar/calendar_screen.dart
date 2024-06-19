import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';
import '../../../models/calendar_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<EventModel> events = [];
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  List<EventModel> _getEventsfromDay(DateTime date) {
    return events.where((event) => isSameDay(event.eventDate, date)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const TBTDrawer(),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebaseConstants.eventsCollection)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            List<Map<String, dynamic>> documentData = snapshot
                                .data!.docs
                                .map((e) => e.data())
                                .toList();
                            events = [];
                            for (var i = 0; i < documentData.length; i++) {
                              events.add(EventModel.fromMap(documentData[i]));
                            }

                            return TableCalendar(
                              focusedDay: selectedDay,
                              firstDay: DateTime(2020),
                              lastDay: DateTime(2025),
                              calendarFormat: CalendarFormat.month,
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              daysOfWeekVisible: true,
                              daysOfWeekStyle: const DaysOfWeekStyle(
                                weekdayStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                weekendStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                              ),
                              daysOfWeekHeight: 25,
                              onDaySelected:
                                  (DateTime selectDay, DateTime focusDay) {
                                setState(() {
                                  selectedDay = selectDay;
                                  focusedDay = focusDay;
                                });
                              },
                              selectedDayPredicate: (DateTime date) {
                                return isSameDay(selectedDay, date);
                              },
                              eventLoader: _getEventsfromDay,
                              calendarStyle: CalendarStyle(
                                isTodayHighlighted: true,
                                selectedDecoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                selectedTextStyle:
                                    const TextStyle(color: Colors.white),
                                todayDecoration: BoxDecoration(
                                  color: Colors.purpleAccent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                defaultDecoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                weekendDecoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                              ),
                            );
                          }
                        },
                      ),
                      //  event detayları
                      SingleChildScrollView(
                        child: Column(
                          children: _getEventsfromDay(selectedDay)
                              .map(
                                (EventModel event) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  event.eventTitle,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Eğitmen: ${event.eventId}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                event.eventDate.day.toString(),
                                                // '${event.eventDate.day.toString().padLeft(2, "0")}.${event.date.month.toString().padLeft(2, "0")}.${event.date.year}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                event.eventDate.toString(),
                                                //'${event.eventDate.toString().padLeft(2, "0")}:${event.minute.toString().padLeft(2, "0")}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
