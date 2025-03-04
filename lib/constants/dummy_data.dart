import 'package:crm_track/models/models.dart';
import 'package:flutter/material.dart';

List<TaskDetail> dummyTask = [
  // 10 tasks for today
  for (int i = 1; i <= 10; i++)
    TaskDetail(
      id: i,
      title: 'Task $i',
      desc: 'Description of task $i',
      dueDate: DateTime.now(),
      priority: TaskPriority.values[i % 3],
      status: TaskStatus.values[i % 5],
      sender: SenderDetail(
        assignor: 'Sender $i',
        cc: ['cc$i@email.com', 'cc${i + 1}@email.com'],
      ),
      customer: CustomerDetail(
        name: 'Customer $i',
        email: 'customer$i@email.com',
        phone: '123-456-789$i',
        jobTitle: 'Job Title $i',
        company: 'Company $i',
      ),
      product: ProductDetail(
        name: 'Product $i',
        businessLine: 'Business Line $i',
      ),
      startTime: TimeOfDay(hour: 9 + (i % 5), minute: 0),
      endTime: TimeOfDay(hour: 10 + (i % 5), minute: 30),
      isComplete: i % 2 == 0,
      type: i % 2 == 0 ? 'Follow up' : 'Meeting',
    ),

  for (int a = 1; a <= 10; a++)
    // 5 tasks for the next 5 days
    for (int i = a; i < 10; i++)
      TaskDetail(
        id: i,
        title: 'Task $i',
        desc: 'Description of task $i',
        dueDate: DateTime.now().add(Duration(days: a)),
        priority: TaskPriority.values[i % 3],
        status: TaskStatus.values[i % 5],
        sender: SenderDetail(
          assignor: 'Sender $i',
          cc: ['cc$i@email.com', 'cc${i + 1}@email.com'],
        ),
        customer: CustomerDetail(
          name: 'Customer $i',
          email: 'customer$i@email.com',
          phone: '123-456-789$i',
          jobTitle: 'Job Title $i',
          company: 'Company $i',
        ),
        product: ProductDetail(
          name: 'Product $i',
          businessLine: 'Business Line $i',
        ),
        startTime: TimeOfDay(hour: 9 + (i % 5), minute: 0),
        endTime: TimeOfDay(hour: 10 + (i % 5), minute: 30),
        isComplete: i % 2 == 0,
        type: i % 2 == 0 ? 'Follow up' : 'Meeting',
      ),
];

/// **Fungsi untuk mendapatkan daftar tanggal dalam satu minggu**
List<Map<String, dynamic>> getDate({int weeksAfter = 0}) {
  final any = DateTime.now().add(const Duration(days: 2));
  final dateOnly = DateTime(any.year, any.month, any.day);

  // List nama hari dan bulan
  final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
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

  // Geser minggu sesuai weeksAfter
  final startOfNextWeek = dateOnly.add(Duration(days: 7 * weeksAfter));

  // Buat daftar tanggal dalam seminggu
  return List.generate(7, (i) {
    final currentDate = startOfNextWeek
        .subtract(Duration(days: startOfNextWeek.weekday - (i + 1)));
    return {
      'date': currentDate,
      'day': dayNames[i],
      'month': monthNames[currentDate.month - 1],
      'year': currentDate.year,
    };
  });
}
