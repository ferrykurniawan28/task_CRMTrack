import 'package:flutter/material.dart';

import '../models/task_model.dart';

List<TaskModel> tasksData = [
  // Hari 1
  TaskModel(
    title: "Meeting with client A",
    type: "Meeting",
    isCompleted: false,
    startTime: TimeOfDay(hour: 9, minute: 0), // Menggunakan TimeOfDay
    endTime: TimeOfDay(hour: 10, minute: 0),
    desc: "Discuss project scope",
    doDate: DateTime(2025, 2, 24), // Tanggal tertentu
  ),
  TaskModel(
    title: "Follow up call with Client B",
    type: "Follow up",
    isCompleted: true,
    startTime: TimeOfDay(hour: 11, minute: 0),
    endTime: TimeOfDay(hour: 11, minute: 30),
    desc: "Check project progress",
    doDate: DateTime(2025, 2, 24),
  ),
  TaskModel(
    title: "Team Standup Meeting",
    type: "Meeting",
    isCompleted: false,
    startTime: TimeOfDay(hour: 14, minute: 0),
    endTime: TimeOfDay(hour: 14, minute: 30),
    desc: "Daily sync",
    doDate: DateTime(2025, 2, 24),
  ),

  // Hari 2
  TaskModel(
    title: "Presentation with client C",
    type: "Meeting",
    isCompleted: true,
    startTime: TimeOfDay(hour: 10, minute: 0),
    endTime: TimeOfDay(hour: 11, minute: 0),
    desc: "Present new strategy",
    doDate: DateTime(2025, 2, 25), // Tanggal berbeda
  ),
  TaskModel(
    title: "Product Review Session",
    type: "Meeting",
    isCompleted: false,
    startTime: TimeOfDay(hour: 15, minute: 0),
    endTime: TimeOfDay(hour: 16, minute: 0),
    desc: "Review new product features",
    doDate: DateTime(2025, 2, 25),
  ),

  // Hari 3
  TaskModel(
    title: "Brainstorming Session",
    type: "Meeting",
    isCompleted: false,
    startTime: TimeOfDay(hour: 10, minute: 30),
    endTime: TimeOfDay(hour: 12, minute: 0),
    desc: "Discuss marketing ideas",
    doDate: DateTime(2025, 2, 26), // Tanggal berbeda
  ),
  TaskModel(
    title: "Follow up email to Client D",
    type: "Follow up",
    isCompleted: true,
    startTime: TimeOfDay(hour: 13, minute: 0),
    endTime: TimeOfDay(hour: 13, minute: 30),
    desc: "Send project details",
    doDate: DateTime(2025, 2, 26),
  ),

  // Hari 4
  TaskModel(
    title: "HR Policy Meeting",
    type: "Meeting",
    isCompleted: false,
    startTime: TimeOfDay(hour: 9, minute: 30),
    endTime: TimeOfDay(hour: 10, minute: 30),
    desc: "Discuss company policy updates",
    doDate: DateTime(2025, 2, 27), // Tanggal berbeda
  ),
  TaskModel(
    title: "Technical Workshop",
    type: "Meeting",
    isCompleted: true,
    startTime: TimeOfDay(hour: 14, minute: 0),
    endTime: TimeOfDay(hour: 15, minute: 30),
    desc: "Training for new tech tools",
    doDate: DateTime(2025, 2, 27),
  ),

  // Hari 5
  TaskModel(
    title: "One-on-One with Manager",
    type: "Meeting",
    isCompleted: false,
    startTime: TimeOfDay(hour: 10, minute: 0),
    endTime: TimeOfDay(hour: 10, minute: 45),
    desc: "Performance review",
    doDate: DateTime(2025, 2, 28), // Tanggal berbeda
  ),
  TaskModel(
    title: "Quarterly Planning",
    type: "Meeting",
    isCompleted: true,
    startTime: TimeOfDay(hour: 15, minute: 0),
    endTime: TimeOfDay(hour: 17, minute: 0),
    desc: "Plan for the next quarter",
    doDate: DateTime(2025, 2, 28),
  ),

  // Hari 6
  TaskModel(
    title: "Client Support Call",
    type: "Follow up",
    isCompleted: false,
    startTime: TimeOfDay(hour: 11, minute: 30),
    endTime: TimeOfDay(hour: 12, minute: 0),
    desc: "Resolve client issues",
    doDate: DateTime(2025, 3, 1), // Tanggal berbeda
  ),
  TaskModel(
    title: "Design Review Meeting",
    type: "Meeting",
    isCompleted: true,
    startTime: TimeOfDay(hour: 14, minute: 0),
    endTime: TimeOfDay(hour: 15, minute: 0),
    desc: "Check UI/UX improvements",
    doDate: DateTime(2025, 3, 1),
  ),

  // Hari 7
  TaskModel(
    title: "Marketing Strategy Discussion",
    type: "Meeting",
    isCompleted: false,
    startTime: TimeOfDay(hour: 9, minute: 0),
    endTime: TimeOfDay(hour: 10, minute: 30),
    desc: "Plan marketing campaigns",
    doDate: DateTime(2025, 3, 2), // Tanggal berbeda
  ),
  TaskModel(
    title: "Code Review Session",
    type: "Meeting",
    isCompleted: true,
    startTime: TimeOfDay(hour: 13, minute: 0),
    endTime: TimeOfDay(hour: 14, minute: 30),
    desc: "Review latest feature code",
    doDate: DateTime(2025, 3, 2),
  ),
];
