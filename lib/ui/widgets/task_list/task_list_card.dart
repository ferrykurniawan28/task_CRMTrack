import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/models.dart';

class TaskListCard extends StatelessWidget {
  const TaskListCard({
    super.key,
    required this.task,
  });
  final TaskDetail task;

  @override
  Widget build(BuildContext context) {
    Color cardColor;
    String priority;

    switch (task.priority) {
      case TaskPriority.low:
        cardColor = const Color(0xFF198754);
        priority = 'Low';
        break;
      case TaskPriority.normal:
        cardColor = const Color(0xFF01BAEF);
        priority = 'Normal';
        break;
      case TaskPriority.high:
        cardColor = primaryColor;
        priority = 'High';
        break;
      default:
        cardColor = const Color(0xFF198754);
        priority = 'Low';
    }
    return Container(
      // width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 6,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          top: BorderSide(
            color: cardColor,
            width: 1,
          ),
          bottom: BorderSide(
            color: cardColor,
            width: 1,
          ),
          left: BorderSide(
            color: cardColor,
            width: 4,
          ),
          right: BorderSide(
            color: cardColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          spacerHeight(8),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Icon(Icons.calendar_month_outlined),
                    Image.asset('assets/icon/calendar2-day.png'),
                    spacerWidth(4),
                    Text(
                      DateFormat('dd MMMM yyyy').format(task.dueDate),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon/lightning-fill.png',
                      color: cardColor,
                    ),
                    spacerWidth(4),
                    Text(
                      priority,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: medium,
                        color: cardColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
