// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm_track/cubit/task/task_cubit.dart';
import 'home_list_card.dart';

class HomeTaskListWidget extends StatefulWidget {
  const HomeTaskListWidget({super.key});

  @override
  State<HomeTaskListWidget> createState() => _HomeTaskListWidgetState();
}

class _HomeTaskListWidgetState extends State<HomeTaskListWidget> {
  @override
  void initState() {
    super.initState();

    context.read<TaskCubit>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border(
          top: BorderSide(color: primaryColor, width: 1),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today Tasks',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Text.rich(
                      TextSpan(
                        text: '1 task',
                        children: [
                          TextSpan(
                            text: ' completed ',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'out of 10',
                          ),
                        ],
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View all tasks',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is TaskError) {
                  return Center(child: Text(state.message));
                }
                if (state is TaskLoaded) {
                  final data = state.tasks;
                  if (data.isEmpty) {
                    return Center(child: Text('No tasks'));
                  }

                  final filteredData = data.where(
                    (element) {
                      return element.dueDate.day == DateTime.now().day &&
                          element.dueDate.month == DateTime.now().month &&
                          element.dueDate.year == DateTime.now().year;
                    },
                  ).toList();

                  return ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      final dataTask = filteredData[index];
                      final startTime = dataTask.startTime;
                      return HomeListCard(
                        isCompleted: dataTask.isComplete,
                        time: startTime.format(context),
                        title: dataTask.title,
                        type: dataTask.type,
                      );
                    },
                  );
                }
                return Center(child: Text('Unavailable state'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
