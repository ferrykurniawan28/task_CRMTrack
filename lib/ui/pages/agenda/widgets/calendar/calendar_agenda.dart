import 'package:crm_track/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../helpers/helpers.dart';

class CalendarAgenda extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  DateTime selectedDate;
  final Function(DateTime) onMonthChange;
  CalendarAgenda({
    super.key,
    required this.onDateSelected,
    required this.selectedDate,
    required this.onMonthChange,
  });

  @override
  State<CalendarAgenda> createState() => _CalendarAgendaState();
}

class _CalendarAgendaState extends State<CalendarAgenda> {
  late DateTime _focusedDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusedDay = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    DateTime _selectedDay = widget.selectedDate;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(1970),
            lastDay: DateTime(2970),
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            rowHeight: 43,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                print('day ${_selectedDay} ${_focusedDay}');
              });
              widget.onDateSelected(_selectedDay);
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
              widget.onMonthChange(focusedDay);
            },
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(color: Colors.transparent),
              titleCentered: false,
              formatButtonShowsNext: false,
              formatButtonVisible: false,
              leftChevronVisible: false,
              rightChevronVisible: false,
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: kColorLightGrey,
                shape: BoxShape.circle,
              ),
              todayDecoration:
                  BoxDecoration(color: kColorLightGrey, shape: BoxShape.circle),
              todayTextStyle: TextStyle(color: Colors.black),
              selectedTextStyle: TextStyle(color: Colors.black),
              weekendTextStyle: TextStyle(color: kColorRed),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(color: kColorRed),
              dowTextFormatter: (date, locale) {
                return ['M', 'T', 'W', 'T', 'F', 'S', 'S'][date.weekday - 1];
              },
            ),
          ),
        ],
      ),
    );
  }
}
