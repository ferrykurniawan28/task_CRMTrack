import 'package:flutter/material.dart';

import '../../../../../helpers/filter.dart';
import '../../../../../helpers/helpers.dart';
import '../../../../../models/models.dart';
import 'agenda_card.dart';
import 'focus_agenda_detail_card.dart';
import 'update_status_agenda.dart';

void _updateAgenda(TaskStatus dataStatus, int? id, BuildContext context) {
  // print('STATUS AWAL');
  // print(dataStatus);

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) {
      return UpdateStatusAgenda(
        status: dataStatus,
        id: id,
      );
    },
  );
}

class AgendaCardAnimateNow extends StatefulWidget {
  final TaskDetail data;
  final bool isExpanded;
  final String timeRange;
  final Function(bool) onChange;

  const AgendaCardAnimateNow({
    super.key,
    required this.data,
    required this.isExpanded,
    required this.timeRange,
    required this.onChange,
  });

  @override
  State<AgendaCardAnimateNow> createState() => _AgendaCardAnimateNowState();
}

class _AgendaCardAnimateNowState extends State<AgendaCardAnimateNow> {
  @override
  Widget build(BuildContext context) {
    var isExpanded = widget.isExpanded;
    var data = widget.data;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
            widget.onChange(isExpanded);
          },
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            duration: const Duration(milliseconds: 300),
            child: isExpanded
                ? FocusAgendaDetailCard(
                    customer: data.customer?.company ?? '-',
                    title: data.title,
                    desc: data.desc ?? '-',
                    date: formatDateText(data.dueDate),
                    rangeTime: widget.timeRange,
                    priority: data.priority.name,
                    callbak: () {
                      _updateAgenda(data.status, data.id, context);
                    },
                  )
                : AgendaNow(
                    desc: data.desc ?? '-',
                    endTime: data.endTime,
                    startTime: data.startTime,
                    title: data.title,
                  ),
          ),
        ),
        spacerHeight(12),
      ],
    );
  }
}

class AgendaCardAnimate extends StatefulWidget {
  final TaskDetail data;
  final bool isExpanded;
  final String timeRange;
  final Function(bool) onChange;

  const AgendaCardAnimate({
    super.key,
    required this.data,
    required this.isExpanded,
    required this.onChange,
    required this.timeRange,
  });

  @override
  State<AgendaCardAnimate> createState() => _AgendaCardAnimateState();
}

class _AgendaCardAnimateState extends State<AgendaCardAnimate> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // print('CARD EXPANDED');
            setState(() {
              // Toggle the expansion state
              isExpanded = !isExpanded;
            });
            widget.onChange(isExpanded);
          },
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            duration: const Duration(milliseconds: 300),
            child: isExpanded
                ? FocusAgendaDetailCard(
                    customer: data.customer?.company ?? '-',
                    title: data.title,
                    desc: data.desc ?? '-',
                    date: formatDateText(data.dueDate),
                    rangeTime: widget.timeRange,
                    priority: data.priority.name,
                    callbak: () {
                      _updateAgenda(data.status, data.id, context);
                    },
                  )
                : AgendaCard(
                    desc: data.desc ?? '-',
                    endTime: data.endTime,
                    startTime: data.startTime,
                    title: data.title,
                    color: getPriorityColor(data.priority.name),
                  ),
          ),
        ),
        spacerHeight(12),
      ],
    );
  }
}
