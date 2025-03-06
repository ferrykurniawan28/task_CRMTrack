import 'package:crm_track/cubit/task_list/task_list_cubit.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/dummy_data.dart';
import '../../../../../helpers/dash_line.dart';
import '../../../../../models/models.dart';

class UpdateStatusAgenda extends StatefulWidget {
  final TaskStatus status;
  final int? id;
  const UpdateStatusAgenda({super.key, required this.status, required this.id});

  @override
  State<UpdateStatusAgenda> createState() => _UpdateStatusAgendaState();
}

class _UpdateStatusAgendaState extends State<UpdateStatusAgenda> {
  late TaskStatus selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize:
                MainAxisSize.min, // Ensure the column takes minimum height
            children: [
              const Text(
                'Update Status',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
              spacerHeight(12),
              CustomPaint(
                size: const Size(double.infinity, 1),
                painter: DashedLinePainter(),
              ),
              spacerHeight(12),
              Column(
                children: TaskStatus.values
                    .map((status) => _radioUpdateAgenda(status))
                    .toList(),
              ),
              spacerHeight(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  spacerWidth(8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        updateTaskStatus(widget.id, selectedStatus);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              spacerHeight(12),
            ],
          ),
        );
      },
    );
  }

  void updateTaskStatus(int? id, TaskStatus newStatus) {
    int index = dummyTask.indexWhere((task) => task.id == id);

    if (index != -1) {
      setState(() {
        dummyTask[index] = TaskDetail(
          id: dummyTask[index].id,
          title: dummyTask[index].title,
          desc: dummyTask[index].desc,
          dueDate: dummyTask[index].dueDate,
          priority: dummyTask[index].priority,
          status: newStatus,
          sender: dummyTask[index].sender,
          customer: dummyTask[index].customer,
          product: dummyTask[index].product,
          startTime: dummyTask[index].startTime,
          endTime: dummyTask[index].endTime,
          isComplete: dummyTask[index].isComplete,
          type: dummyTask[index].type,
        );
      });

      context.read<TaskListCubit>().updateTask(dummyTask[index]);
      Navigator.pop(context);
    }
    // print('STATUS NOW\n$newStatus');
  }

  Widget _radioUpdateAgenda(TaskStatus status) {
    return RadioListTile<TaskStatus>(
      title: Text(
        status == TaskStatus.notStarted
            ? 'Not Started'
            : status == TaskStatus.inProgress
                ? 'In Progress'
                : status == TaskStatus.completed
                    ? 'Completed'
                    : status == TaskStatus.deffered
                        ? 'Deffered'
                        : 'Other',
      ),
      value: status,
      groupValue: selectedStatus,
      dense: true,
      visualDensity: VisualDensity.compact,
      onChanged: (value) {
        setState(() {
          selectedStatus = value!;
        });
      },
      activeColor: primaryColor,
      contentPadding: EdgeInsets.zero,
    );
  }
}
