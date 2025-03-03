// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crm_track/ui/pages/agenda/widgets/cards/agenda_card_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/task/task_cubit.dart';
import '../../../helpers/filter.dart';
import '../../../helpers/helpers.dart';
import '../../widgets/header_list.dart';
import 'widgets/calendar/calendar_agenda.dart';
import 'widgets/calendar/calendar_agenda_detail.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedMonth = DateTime.now();

  ScrollController _scrollController = ScrollController();
  double _calendarHeight = 350.0;
  bool _isSmallCalendar = false;
  List<bool> isExpanded = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<TaskCubit>(context).getTasks();
  }

  void _onScroll() {
    if (_scrollController.offset > 20 && !_isSmallCalendar) {
      setState(() {
        _calendarHeight = 140.0;
        _isSmallCalendar = true;
      });
    } else if (_scrollController.offset <= 20 && _isSmallCalendar) {
      setState(() {
        _calendarHeight = 350.0;
        _isSmallCalendar = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Agenda',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 12,
            child: Column(
              children: [
                Text(
                  formatMonth(_selectedMonth) +
                      ' ' +
                      _selectedMonth.year.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                spacerHeight(8),
                AnimatedContainer(
                  alignment: Alignment.topCenter,
                  duration: Duration(milliseconds: 500),
                  height: 350,
                  child: _isSmallCalendar
                      ? CalendarAgendaDetail(
                          focusedDate: _selectedDate,
                          onSelected: (newDate) {
                            setState(() {
                              _selectedDate = newDate;
                            });
                          },
                        )
                      : CalendarAgenda(
                          onMonthChange: (newMonth) {
                            setState(() {
                              _selectedMonth = newMonth;
                            });
                          },
                          onDateSelected: (newDate) {
                            setState(() {
                              _selectedDate = newDate;
                            });
                          },
                          selectedDate: _selectedDate,
                        ),
                ),
              ],
            ),
          ),
          Positioned(
            top: _calendarHeight + 5,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<TaskCubit, TaskState>(
                    builder: (context, state) {
                      if (state is TaskLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is TaskError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      if (state is TaskLoaded) {
                        final data = state.tasks;
                        print('DATA FROM STATE WITHOUT SELECTED FILTER');
                        print(data
                            .map((data) =>
                                'id: ${data.id}, Tanggal: ${formatDateAndTime(data.dueDate, data.startTime, data.endTime)['date']}\n')
                            .toList());
                        print('SAMPAI SINI');

                        final filteredData =
                            filterDataBySelectedDate(data, _selectedDate);
                        print('DATA DETAIL SELECTED');
                        print(filteredData);
                        final totalData = filteredData.length;

                        if (isExpanded.length != filteredData.length) {
                          isExpanded = List.generate(
                              filteredData.length, (index) => false);
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              HeaderList(
                                totalData: totalData,
                                date: _selectedDate,
                              ),
                              spacerHeight(14),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: totalData,
                                  itemBuilder: (context, index) {
                                    final singleData = filteredData[index];
                                    final startTime = singleData.startTime;
                                    final endTime = singleData.endTime;

                                    final time = formatDateAndTime(
                                        singleData.dueDate, startTime, endTime);

                                    final dataStatus = singleData.status;

                                    if (startTime.hour >=
                                            TimeOfDay.now().hour &&
                                        endTime.hour <= TimeOfDay.now().hour) {
                                      return AgendaCardAnimateNow(
                                        data: singleData,
                                        isExpanded: isExpanded[index],
                                        timeRange: time['timeRange'].toString(),
                                        onChange: (expand) {
                                          setState(() {
                                            isExpanded[index] = expand;
                                          });
                                        },
                                      );
                                    } else {
                                      return AgendaCardAnimate(
                                        data: singleData,
                                        isExpanded: isExpanded[index],
                                        onChange: (expand) {
                                          setState(() {
                                            isExpanded[index] = expand;
                                          });
                                        },
                                        timeRange: time['timeRange'].toString(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: Text('Unvailable State'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
