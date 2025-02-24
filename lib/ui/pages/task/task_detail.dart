import 'package:crm_track/cubit/task_list/task_list_cubit.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/task_detail.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskListDetail extends StatelessWidget {
  final TaskDetail task;
  const TaskListDetail({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    String priority;
    String progress;

    switch (task.priority) {
      case TaskPriority.low:
        priority = 'Low';
        break;
      case TaskPriority.normal:
        priority = 'Medium';
        break;
      case TaskPriority.high:
        priority = 'High';
        break;
      default:
        priority = 'Low';
    }

    switch (task.status) {
      case TaskStatus.notStarted:
        progress = 'Todo';
        break;
      case TaskStatus.inProgress:
        progress = 'On Progress';
        break;
      case TaskStatus.completed:
        progress = 'Completed';
        break;
      case TaskStatus.deffered:
        progress = 'On Hold';
        break;
      case TaskStatus.other:
        progress = 'Closed';
        break;
      default:
        progress = 'Todo';
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Task',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: medium,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                spacerHeight(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                spacerHeight(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Due Date',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/calendar2-day.png',
                              // height: 20,
                              // width: 20,
                              color: Colors.white,
                            ),
                            spacerWidth(4),
                            Text(
                              DateFormat('dd MMMM yyyy').format(task.dueDate),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: medium,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    spacerWidth(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Priority',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/lightning-fill.png',
                              // height: 20,
                              // width: 20,
                              color: Colors.white,
                            ),
                            spacerWidth(4),
                            Text(
                              priority,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: medium,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            // Image.asset(
                            //   'assets/icon/lightning-fill.png',
                            //   color: Colors.white,
                            // ),
                            const Icon(
                              Icons.play_circle_fill,
                              size: 16,
                              color: Colors.white,
                            ),
                            spacerWidth(4),
                            Text(
                              progress,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: medium,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          spacerHeight(12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            color: const Color(0xFFF9FAFB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sender Detail',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: medium,
                    color: Colors.black,
                  ),
                ),
                spacerHeight(6),
                Row(
                  children: [
                    const Text(
                      'Assignor',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      task.sender.assignor,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                spacerHeight(6),
                Row(
                  children: [
                    const Text(
                      'cc',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      task.sender.cc.join(', '),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          spacerHeight(14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            color: const Color(0xFFF9FAFB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Detail',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: medium,
                    color: Colors.black,
                  ),
                ),
                spacerHeight(6),
                Row(
                  children: [
                    const Text(
                      'Customer Name',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      task.customer.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                spacerHeight(6),
                Row(
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      task.customer.email,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                spacerHeight(6),
                Row(
                  children: [
                    const Text(
                      'Phone',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      task.customer.phone,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                spacerHeight(6),
                Row(
                  children: [
                    const Text(
                      'Job Title',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      task.customer.jobTitle,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                spacerHeight(6),
                Row(
                  children: [
                    const Text(
                      'Company',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      task.customer.company,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          spacerHeight(14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            color: const Color(0xFFF9FAFB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Detail',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: medium,
                    color: Colors.black,
                  ),
                ),
                spacerHeight(6),
                Row(
                  children: [
                    const Text(
                      'Product Name',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      task.product.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                spacerHeight(6),
                Row(
                  children: [
                    const Text(
                      'Line of Business',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      task.product.businessLine,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 6,
          bottom: 20,
          left: 18,
          right: 18,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            //open modal
            showModalBottomSheet(
              context: context,
              isScrollControlled:
                  true, // Allows the modal to adjust dynamically
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context)
                            .viewInsets
                            .bottom, // Adjust for keyboard
                      ),
                      child: Wrap(
                        // Wrap makes the modal height fit content
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize
                                  .min, // Ensures it doesn't take extra space
                              children: [
                                Text(
                                  'Update Status',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                                spacerHeight(12),
                                const DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 2.0,
                                  dashLength: 4.0,
                                  dashColor: Color(0xFFDDC9A9),
                                  dashRadius: 0.0,
                                  dashGapLength: 4.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                spacerHeight(12),
                                Column(
                                  children: TaskStatus.values.map((status) {
                                    String statusText;
                                    switch (status) {
                                      case TaskStatus.notStarted:
                                        statusText = 'Not Started';
                                        break;
                                      case TaskStatus.inProgress:
                                        statusText = 'In Progress';
                                        break;
                                      case TaskStatus.completed:
                                        statusText = 'Completed';
                                        break;
                                      case TaskStatus.deffered:
                                        statusText = 'Deferred';
                                        break;
                                      case TaskStatus.other:
                                        statusText = 'Other';
                                        break;
                                      default:
                                        statusText = 'Not Started';
                                    }
                                    return RadioListTile<TaskStatus>(
                                      dense: true,
                                      visualDensity: VisualDensity.compact,
                                      title: Text(
                                        statusText,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      selectedTileColor: primaryColor,
                                      activeColor: primaryColor,
                                      value: status,
                                      splashRadius: 20,
                                      groupValue: task.status,
                                      onChanged: (value) {
                                        setState(() {
                                          task.status = value!;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                                spacerHeight(12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              side: BorderSide(
                                                color: primaryColor,
                                              )),
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: medium,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    spacerWidth(12),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          TaskDetail updatedTask = task;
                                          updatedTask.status = task.status;

                                          // Update the task status
                                          context
                                              .read<TaskListCubit>()
                                              .updateTask(updatedTask);

                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: Text(
                                          'Update Status',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: medium,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            'Update Status',
            style: TextStyle(
                fontSize: 16, fontWeight: medium, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
