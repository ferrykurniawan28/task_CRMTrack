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

  final ScrollController _scrollController = ScrollController();
  double _calendarHeight = 350.0;
  bool _isSmallCalendar = false;
  List<bool> _isExpanded = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<TaskCubit>(context).getTasks();
  }

  void _onScroll() {
    if (_scrollController.offset > 10 && !_isSmallCalendar) {
      setState(() {
        _calendarHeight = 140.0;
        _isSmallCalendar = true;
      });
    } else if (_scrollController.offset <= 10 && _isSmallCalendar) {
      setState(() {
        _calendarHeight = 350.0;
        _isSmallCalendar = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
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
                  '${formatMonth(_selectedMonth)} ${_selectedMonth.year}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                spacerHeight(8),
                AnimatedContainer(
                  alignment: Alignment.topCenter,
                  duration: const Duration(milliseconds: 500),
                  height: _calendarHeight,
                  transform: Matrix4.translationValues(0, 0, 0),
                  curve: Curves.fastOutSlowIn,
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
            child: BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return const Center(
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
                  final filteredData =
                      filterDataBySelectedDate(data, _selectedDate);
                  final totalData = filteredData.length;

                  if (_isExpanded.length != filteredData.length) {
                    _isExpanded =
                        List.generate(filteredData.length, (index) => false);
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
                              final time = formatDateAndTime(
                                singleData.dueDate,
                                singleData.startTime,
                                singleData.endTime,
                              );

                              return AgendaCardAnimate(
                                data: singleData,
                                isExpanded: _isExpanded[index],
                                onChange: (expand) {
                                  setState(() {
                                    _isExpanded[index] = expand;
                                  });
                                },
                                timeRange: time['timeRange'].toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Text('Unavailable State'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
