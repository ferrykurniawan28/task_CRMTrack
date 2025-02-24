// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:crm_track/cubit/task/task_cubit.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/theme/colors.dart';
import 'package:crm_track/ui/widgets/agenda_card.dart';
import 'package:crm_track/ui/widgets/calendar_agenda.dart';
import 'package:crm_track/ui/widgets/header_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TaskCubit>().getTasks();
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
        backgroundColor: kColorRed,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          spacerHeight(8),
          Container(
            alignment: Alignment.bottomCenter,
            height: 270,
            child: Stack(
              children: [
                // Pindahkan garis merah ke bawah
                Positioned(
                  left: -4,
                  right: -4,
                  bottom: 0,
                  // Tambahkan ini agar posisinya di bawah
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: kColorLightGrey,
                    ),
                    height: 40,
                  ),
                ),
                Positioned(
                  bottom: 4,
                  left: 0,
                  right: 0,
                  child: CalendarAgenda(
                    onDateSelected: (newDate) {
                      setState(
                        () {
                          _selectedDate = newDate ?? DateTime.now();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          spacerHeight(21),
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

                  final filteredData = data.where(
                    (element) {
                      return element.doDate!.day == _selectedDate.day &&
                          element.doDate!.month == _selectedDate.month &&
                          element.doDate!.year == _selectedDate.year;
                    },
                  ).toList();

                  final totalData = filteredData.length;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    child: Column(
                      children: [
                        HeaderList(totalData: totalData),
                        spacerHeight(14),
                        Container(
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: totalData,
                              itemBuilder: (context, index) {
                                final singleData = filteredData[index];
                                final startTime = singleData.startTime!;
                                final endTime = singleData.endTime!;
                                List<Color> colors = [
                                  kColorGreen,
                                  kColorLightBlue,
                                  kColorYellow
                                ];
                                Color color =
                                    colors[Random().nextInt(colors.length)];
                                if (startTime.hour >= TimeOfDay.now().hour &&
                                    endTime.hour <= TimeOfDay.now().hour) {
                                  return Column(
                                    children: [
                                      AgendaNow(
                                        desc: singleData.desc!,
                                        endTime: endTime,
                                        startTime: startTime,
                                        title: singleData.title!,
                                      ),
                                      spacerHeight(12),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      AgendaCard(
                                        desc: singleData.desc!,
                                        endTime: endTime,
                                        startTime: startTime,
                                        title: singleData.title!,
                                        color: color,
                                      ),
                                      spacerHeight(12),
                                    ],
                                  );
                                }
                              },
                            ),
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
    );
  }
}
