import 'package:crm_track/cubit/task_list/task_list_cubit.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/dummy_data.dart';
import '../../../../../helpers/dash_line.dart';
import '../../../../../models/models.dart';

class UpdateStatusAgenda extends StatefulWidget {
  TaskStatus status;
  int? id;
  UpdateStatusAgenda({super.key, required this.status, required this.id});

  @override
  State<UpdateStatusAgenda> createState() => _UpdateStatusAgendaState();
}

class _UpdateStatusAgendaState extends State<UpdateStatusAgenda> {
  late TaskStatus selectedStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedStatus = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
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
            size: Size(double.infinity, 1),
            painter: DashedLinePainter(),
          ),
          spacerHeight(12),
          Container(
            child: Column(
              children: [
                _radioUpdateAgenda(TaskStatus.notStarted),
                _radioUpdateAgenda(TaskStatus.inProgress),
                _radioUpdateAgenda(TaskStatus.completed),
                _radioUpdateAgenda(TaskStatus.deffered),
                _radioUpdateAgenda(TaskStatus.other),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
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
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTaskStatus(int? id, TaskStatus newStatus) {
    int index = dummyTask.indexWhere((task) => task.id == id);

    var newDataTask;
    if (index != -1) {
      setState(() {
        newDataTask = dummyTask[index] = TaskDetail(
          id: dummyTask[index].id,
          title: dummyTask[index].title,
          desc: dummyTask[index].desc,
          dueDate: dummyTask[index].dueDate,
          priority: dummyTask[index].priority,
          status: newStatus, // Perbarui status
          sender: dummyTask[index].sender,
          customer: dummyTask[index].customer,
          product: dummyTask[index].product,
          startTime: dummyTask[index].startTime,
          endTime: dummyTask[index].endTime,
          isComplete: dummyTask[index].isComplete,
          type: dummyTask[index].type,
        );
      });

      context.read<TaskListCubit>().updateTask(newDataTask);
      Navigator.pop(context);
    }
    print('STATUS NOW\n$newStatus');
  }

  Widget _radioUpdateAgenda(TaskStatus status) {
    return RadioListTile(
      title: Text(
        status == TaskStatus.values[0]
            ? 'Not Started'
            : status == TaskStatus.values[1]
                ? 'In Progress'
                : status == TaskStatus.values[2]
                    ? 'Completed'
                    : status == TaskStatus.values[3]
                        ? 'Deffered'
                        : 'Other',
      ),
      value: status,
      groupValue: selectedStatus,
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
