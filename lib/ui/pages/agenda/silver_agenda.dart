// ignore_for_file: prefer_const_constructors

import 'package:crm_track/cubit/task_list/task_list_cubit.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/ui/pages/agenda/widgets/calendar/calendar_agenda.dart';
import 'package:crm_track/ui/pages/agenda/widgets/calendar/calendar_agenda_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/filter.dart';
import '../../widgets/header_list.dart';
import 'widgets/cards/agenda_card_animate.dart';

class SilverAgenda extends StatefulWidget {
  const SilverAgenda({super.key});

  @override
  State<SilverAgenda> createState() => _SilverAgendaState();
}

class _SilverAgendaState extends State<SilverAgenda> {
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedMonth = DateTime.now();
  List<bool> isExpanded = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TaskListCubit>().getTasks();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            spacerHeight(12),
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
            Expanded(
              child: BlocBuilder<TaskListCubit, TaskListState>(
                builder: (context, state) {
                  if (state is TaskListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is TaskListError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  if (state is TaskListLoaded) {
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
                      isExpanded =
                          List.generate(filteredData.length, (index) => false);
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                pinned: true,
                                expandedHeight: 320.0,
                                toolbarHeight: 160,
                                floating: true,
                                flexibleSpace: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final currentHeight = constraints.maxHeight;
                                    final isExpanded = currentHeight > 200;

                                    return Column(
                                      children: [
                                        Expanded(
                                          child: AnimatedSwitcher(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            // Custom transition (opsional)
                                            transitionBuilder:
                                                (child, animation) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: SizeTransition(
                                                  sizeFactor: animation,
                                                  child: child,
                                                ),
                                              );
                                            },

                                            child: isExpanded
                                                ? FlexibleSpaceBar(
                                                    background: CalendarAgenda(
                                                      onDateSelected:
                                                          (selectedDate) {
                                                        setState(() {
                                                          _selectedDate =
                                                              selectedDate;
                                                        });
                                                      },
                                                      selectedDate:
                                                          _selectedDate,
                                                      onMonthChange:
                                                          (selectedMonth) {
                                                        setState(() {
                                                          _selectedMonth =
                                                              selectedMonth;
                                                        });
                                                      },
                                                    ),
                                                  )
                                                : CalendarAgendaDetail(
                                                    focusedDate: _selectedDate,
                                                    onSelected: (selectedDate) {
                                                      setState(() {
                                                        _selectedDate =
                                                            selectedDate;
                                                      });
                                                    },
                                                  ),
                                          ),
                                        ),
                                        spacerHeight(5),
                                        HeaderList(
                                          totalData: totalData,
                                          date: _selectedDate,
                                        ),
                                        spacerHeight(16),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
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
                                  childCount: totalData,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: Text('Unvailable state'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
