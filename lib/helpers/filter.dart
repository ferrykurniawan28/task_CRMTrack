import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/task_detail.dart';
import 'package:flutter/material.dart';

///filter task list model
List<TaskDetail> filterTaskListHariIni(List<TaskDetail> dataList) {
  return dataList.where((element) {
    final date = element.dueDate;
    return date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year;
  }).toList();
}

///priority color
Color getPriorityColor(String priority) {
  if (priority == 'high') {
    return primaryColor;
  } else if (priority == 'low') {
    return kColorGreen;
  } else {
    return kColorLightBlue;
  }
}

///formatter month
String formatMonth(DateTime dateTime) {
  final monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  return monthNames[dateTime.month - 1];
}

///format full date text
String formatDateText(DateTime onlyDate) {
  final dateText = '${onlyDate.day} ${formatMonth(onlyDate)} ${onlyDate.year}';

  return dateText;
}

///format date and time
Map<String, String> formatDateAndTime(
    DateTime data, TimeOfDay startTime, TimeOfDay endTime) {
  final any = data;
  final onlyDate = DateTime(any.day, any.month, any.year);

  final dateText = formatDateText(data);

  // Format the start and end time
  final startFormatted =
      '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
  final endFormatted =
      '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}';

  final timeRange = '$startFormatted - $endFormatted';

  // Return a map with 'date' and 'timeRange' as keys
  return {
    'date': dateText,
    'timeRange': timeRange,
  };
}

///filter by selected date
List<TaskDetail> filterDataBySelectedDate(
    List<TaskDetail> dataList, DateTime selectedDate) {
  return dataList.where((element) {
    return element.dueDate!.day == selectedDate.day &&
        element.dueDate!.month == selectedDate.month &&
        element.dueDate!.year == selectedDate.year;
  }).toList();
}
