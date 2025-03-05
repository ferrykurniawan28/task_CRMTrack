import 'package:flutter/material.dart';

import '../constants/dummy_data.dart';
import '../models/models.dart';

part './themes.dart';
part './utils.dart';

SizedBox spacerHeight(double height) {
  return SizedBox(height: height);
}

SizedBox spacerWidth(double width) {
  return SizedBox(width: width);
}

void showDialogWidget(
  BuildContext context,
  Function() callBack,
  String title,
  String message,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              callBack();
              Navigator.pop(context);
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}

void addData(
  String title,
  String? desc,
  DateTime dueDate,
  TaskPriority priority,
  TaskStatus status,
  String assignor,
  List<String>? cc,
  CustomerDetail? customer,
  ProductDetail? product,
  String type,
) {
  TimeOfDay addTimeOfDay(TimeOfDay time, int addHours, int addMinutes) {
    int totalMinutes =
        time.hour * 60 + time.minute + (addHours * 60) + addMinutes;
    int newHour = (totalMinutes ~/ 60) % 24; // Agar tetap dalam format 24 jam
    int newMinute = totalMinutes % 60;
    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  final sender = SenderDetail(assignor: assignor, cc: cc);
  final startTime = TimeOfDay.now();
  final endTime = addTimeOfDay(startTime, 3, 0);
  final newData = TaskDetail(
    title: title,
    desc: desc,
    dueDate: dueDate,
    priority: priority,
    status: status,
    sender: sender,
    customer: customer,
    product: product,
    endTime: endTime,
    startTime: startTime,
    isComplete: false,
    type: type,
  );

  return dummyTask.add(newData);
}
