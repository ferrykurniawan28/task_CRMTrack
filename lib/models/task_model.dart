import 'package:flutter/material.dart';

class TaskModel {
  final String? title;
  final String? type;
  final bool? isCompleted;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String? desc;
  final DateTime? doDate;

  TaskModel({
    required this.title,
    required this.type,
    required this.isCompleted,
    required this.startTime,
    this.desc,
    this.doDate,
    this.endTime,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      type: json['type'],
      isCompleted: json['isCompleted'],
      startTime: json['time'],
      desc: json['desc'],
      doDate: json['doDate'],
      endTime: json['enTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'isCompleted': isCompleted,
      'time': startTime,
      'desc': desc,
      'doDate': doDate,
      'endTime': endTime,
    };
  }
}
