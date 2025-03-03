import 'package:crm_track/constants/dummy_data.dart';
import 'package:crm_track/helpers/filter.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';

import 'custom_calendar.dart';

class CalendarAgendaDetail extends StatefulWidget {
  DateTime focusedDate;
  Function(DateTime) onSelected;
  CalendarAgendaDetail(
      {super.key, required this.focusedDate, required this.onSelected});

  @override
  State<CalendarAgendaDetail> createState() => _CalendarAgendaDetailState();
}

class _CalendarAgendaDetailState extends State<CalendarAgendaDetail> {
  @override
  Widget build(BuildContext context) {
    final month = formatMonth(widget.focusedDate);
    final year = widget.focusedDate.year.toString();

    DateTime focusedDate = widget.focusedDate;

    print('FOCUSED DATE YANG DI DAPAT');
    print('${focusedDate.day} : ${focusedDate.month} : ${focusedDate.year}');

    return Container(
      child: Column(
        children: [
          Container(
            height: 75,
            child: PageView.builder(
              itemCount: getDate().length,
              itemBuilder: (context, index) {
                final week = getDate(weeksAfter: index);

                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: week.length,
                        itemBuilder: (context, index) {
                          final dateData = week[index];
                          final date = dateData['date'] as DateTime;
                          final dayName = dateData['day'].toString();

                          print(dateData);

                          if (date.day == DateTime.now().day &&
                              date.month == DateTime.now().month &&
                              date.year == DateTime.now().year &&
                              focusedDate != DateTime.now()) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.focusedDate = date;
                                });
                                widget.onSelected(widget.focusedDate);
                              },
                              child: CustomCalendarToday(
                                date: date.day.toString(),
                                dayName: dayName,
                              ),
                            );
                          } else if (date.day == focusedDate.day &&
                                  date.month == focusedDate.month &&
                                  date.year == focusedDate.year ||
                              focusedDate == DateTime.now()) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.focusedDate = date;
                                });
                                widget.onSelected(widget.focusedDate);
                              },
                              child: CustomCalendarSelected(
                                date: date.day.toString(),
                                dayName: dayName,
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.focusedDate = date;
                                });
                                print('FOUSED DATE BERUBAH JADI $focusedDate');
                                widget.onSelected(widget.focusedDate);
                              },
                              child: CustomCalendar(
                                date: date.day.toString(),
                                dayName: dayName,
                              ),
                            );
                          }
                        },
                      )
                    ],
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
