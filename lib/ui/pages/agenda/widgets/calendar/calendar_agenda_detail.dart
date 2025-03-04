import 'package:crm_track/constants/dummy_data.dart';
import 'package:crm_track/helpers/filter.dart';
import 'package:flutter/material.dart';

import 'custom_calendar.dart';

class CalendarAgendaDetail extends StatefulWidget {
  final DateTime focusedDate;
  final Function(DateTime) onSelected;

  const CalendarAgendaDetail(
      {super.key, required this.focusedDate, required this.onSelected});

  @override
  State<CalendarAgendaDetail> createState() => _CalendarAgendaDetailState();
}

class _CalendarAgendaDetailState extends State<CalendarAgendaDetail> {
  late DateTime focusedDate;

  @override
  void initState() {
    super.initState();
    focusedDate = widget.focusedDate;
  }

  @override
  Widget build(BuildContext context) {
    final month = formatMonth(focusedDate);
    final year = focusedDate.year.toString();

    // print('FOCUSED DATE YANG DI DAPAT');
    // print('${focusedDate.day} : ${focusedDate.month} : ${focusedDate.year}');

    return Column(
      children: [
        SizedBox(
          height: 75,
          child: PageView.builder(
            itemCount: getDate().length,
            itemBuilder: (context, index) {
              final week = getDate(weeksAfter: index);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: week.length,
                    itemBuilder: (context, index) {
                      final dateData = week[index];
                      final date = dateData['date'] as DateTime;
                      final dayName = dateData['day'].toString();

                      // print(dateData);

                      if (date.day == DateTime.now().day &&
                          date.month == DateTime.now().month &&
                          date.year == DateTime.now().year &&
                          focusedDate != DateTime.now()) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              focusedDate = date;
                            });
                            widget.onSelected(focusedDate);
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
                              focusedDate = date;
                            });
                            widget.onSelected(focusedDate);
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
                              focusedDate = date;
                            });
                            // print('FOCUSED DATE BERUBAH JADI $focusedDate');
                            widget.onSelected(focusedDate);
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
              );
            },
          ),
        ),
      ],
    );
  }
}
