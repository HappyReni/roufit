
import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/models/log_model.dart';
import 'package:hr_app/models/workout_model.dart';
import 'package:hr_app/provider/log_provider.dart';
import 'package:hr_app/scenes/routine/routine_history_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hr_app/provider/user_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hr_app/models/routine_model.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final List<Color> todayColors = [
    const Color(0xff23b6ed),
    const Color(0xff02d39a),
  ];
  final List<Color> selectedColors = [
    Colors.red,
    Colors.blue,
  ];

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  Map routineHistory;
  int workoutCount;
  int workoutTime;
  int workoutWeight;
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    String date = DateFormat('yyyy-MM-dd').format(selectedDay);
    Navigator.pushNamed(context, 'Routine_history_page', arguments: HistoryParameter(date:date));
    // if (!isSameDay(_selectedDay, selectedDay)) {
    //   setState(() {
    //     _selectedDay = selectedDay;
    //     _focusedDay = focusedDay;
    //   });
    // }
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<dynamic> _getEvents(DateTime dateTime) {
    List<dynamic> events = [];
    String date = DateFormat('yyyy-MM-dd').format(dateTime);
    try {
      events = routineHistory[date].toList();
    } catch (e) {}

    return events;
  }

  @override
  void initState() {
    routineHistory =
        Provider.of<UserProvider>(context, listen: false).getHistory();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      var userData = Provider.of<UserProvider>(context, listen: false);
      Provider.of<UserProvider>(context, listen: false)
          .loadWeeklyWorkouts(context);
      workoutCount = userData.getWorkoutCount();
      workoutTime = userData.getWorkoutTime();
      workoutWeight = userData.getWorkoutWeight();
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: kPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('History', style: kPageTitleStyle),
                IconButton(
                  icon: Icon(Icons.settings),
                  iconSize: 40.0,
                  onPressed: () {
                    setState(() {
                      workoutCount = 0;
                      workoutTime = 0;
                      workoutWeight = 0;
                    });
                    // var _logData =
                    //     Provider.of<LogProvider>(context, listen: false).selLog;
                    // Provider.of<UserProvider>(context, listen: false)
                    //     .addRoutineHistory(DateTime(2021, 11, 2), _logData);
                    Provider.of<UserProvider>(context, listen: false)
                        .clearHistory();
                  },
                ),
              ],
            ),
            kSizedBoxBetweenItems,
            // Text('이번 주 활동', style: kPageSubTitleStyle),
            // kSizedBoxBetweenItems,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Expanded(
            //       flex: 1,
            //       child: Container(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text("$workoutCount", style: kSetDataTextStyle),
            //                 Text(
            //                   "번",
            //                 ),
            //               ],
            //             ),
            //             Text("운동을 했어요"),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: Container(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text("$workoutTime", style: kSetDataTextStyle),
            //                 Text(
            //                   "초",
            //                 ),
            //               ],
            //             ),
            //             Text("동안 운동했어요"),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: Container(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text("$workoutWeight", style: kSetDataTextStyle),
            //                 Text(
            //                   "KG",
            //                 ),
            //               ],
            //             ),
            //             Text("이나 들었어요"),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            kSizedBoxBetweenItems,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('루틴 기록', style: kPageSubTitleStyle),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, 'Routine_history_page'),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('전체보기',
                        style: kPageSubTitleStyle.copyWith(
                            fontSize: 16, color: ThemeData().primaryColor)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TableCalendar(
                shouldFillViewport: true,
                headerStyle: HeaderStyle(
                  headerMargin:
                      EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 10),
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(Icons.arrow_left),
                  rightChevronIcon: Icon(Icons.arrow_right),
                  titleTextStyle: const TextStyle(fontSize: 17.0),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                      gradient: LinearGradient(colors: todayColors),
                      shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(
                    color: ThemeData().primaryColor,
                    shape: BoxShape.circle,
                  ),
                  markersMaxCount: 1,
                  markersAlignment: Alignment.bottomRight,
                  outsideDaysVisible: true,
                  weekendTextStyle: TextStyle().copyWith(color: Colors.red),
                  holidayTextStyle:
                      TextStyle().copyWith(color: Colors.blue[800]),
                ),
                pageAnimationDuration: Duration(milliseconds: 500),
                pageAnimationCurve: Curves.linearToEaseOut,
                locale: 'ko-KR',
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (BuildContext context, DateTime dateTime,
                      List<dynamic> event) {
                    String count = event.length.toString();
                    return count != '0'
                        ? Container(
                            width: 16,
                            height: 16,
                            child: Center(
                              child: Text(
                                count,
                                style: kOutlinedButtonTextStyle,
                              ),
                            ),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: todayColors),
                                shape: BoxShape.circle))
                        : SizedBox();
                  },
                ),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                eventLoader: _getEvents,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: _onDaySelected,
              ),
            ),
            kSizedBoxBetweenItems
          ],
        ),
      ),
    );
  }
}
