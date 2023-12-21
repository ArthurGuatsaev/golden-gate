import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:golden_gate/nav_manager.dart';
import 'package:golden_gate/widgets/calc_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../const/import.dart';

Future showModalSheetDatePick({
  required BuildContext context,
  required ValueNotifier<DateTime> datePick,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 40),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Center(child: Image.asset('assets/images/tire.png')),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                          child: Text('Date',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 40),
                      MyCalendar(
                        value: datePick,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CalcButton(
                      text: 'Done',
                      gradic: gradientButton,
                      function: () =>
                          MyNavigatorManager.instance.simulatorPop(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class MyCalendar extends StatefulWidget {
  final ValueNotifier<DateTime> value;
  const MyCalendar({
    super.key,
    required this.value,
  });

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 450,
      child: TableCalendar(
        selectedDayPredicate: (day) {
          return isSameDay(widget.value.value, day);
        },
        headerVisible: true,
        onDaySelected: (selectedDay, focusedDay) {
          widget.value.value = selectedDay;
          setState(() {});
        },
        availableCalendarFormats: {
          CalendarFormat.month: 'month',
        },
        headerStyle: const HeaderStyle(
            leftChevronIcon: Icon(
              Icons.navigate_before,
              color: primary,
              size: 35,
            ),
            rightChevronIcon: Icon(
              Icons.navigate_next,
              color: primary,
              size: 35,
            ),
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
        calendarStyle: CalendarStyle(
            todayTextStyle: const TextStyle(
                color: primary, fontSize: 20, fontWeight: FontWeight.w600),
            selectedDecoration: const BoxDecoration(
                color: Colors.transparent, shape: BoxShape.circle),
            todayDecoration: BoxDecoration(
                color: primary.withOpacity(0.2), shape: BoxShape.circle),
            selectedTextStyle: const TextStyle(
                color: primary, fontSize: 20, fontWeight: FontWeight.w600),
            weekendTextStyle: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            defaultTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 13,
                fontWeight: FontWeight.w600)),
        firstDay: DateTime.utc(2023, 12, 1),
        lastDay: DateTime.utc(2024, 12, 1),
        focusedDay: DateTime.now(),
      ),
    );
  }
}
