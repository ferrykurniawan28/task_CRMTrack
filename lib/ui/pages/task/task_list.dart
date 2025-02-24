import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/task_list/task_list_cubit.dart';
import '../../widgets/task_list/task_list_card.dart';
import '../../widgets/task_list/task_list_filter.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    context.read<TaskListCubit>().getTasks();
    final List<String> taskFilter = [
      'Todo',
      'On Progress',
      'Completed',
      'On Hold',
      'Closed'
    ];
    int selectedIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            // height: 37,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                hintText: 'Search Task',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFFE6E6E6),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          TaskFilterWidget(
            taskFilter: taskFilter,
            onSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
              print(selectedIndex);
            },
          ),
          spacerHeight(12),
          // ListView.builder(
          //   itemCount: dummyTask.length,
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     final task = dummyTask[index];
          //     return GestureDetector(
          //       onTap: () {
          //         Navigator.pushNamed(context, '/task/detail', arguments: task);
          //       },
          //       child: TaskListCard(task: task),
          //     );
          //   },
          // ),
          Expanded(
            child: BlocBuilder<TaskListCubit, TaskListState>(
              builder: (context, state) {
                if (state is TaskListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TaskListLoaded) {
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/task/detail',
                              arguments: task);
                        },
                        child: TaskListCard(task: task),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No tasks available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
