import 'package:crm_track/models/models.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/filter.dart';
import '../../../../../helpers/helpers.dart';
import 'agenda_card.dart';
import 'focus_agenda_detail_card.dart';
import 'update_status_agenda.dart';

void _updateAgenda(TaskStatus dataStatus, int? id, BuildContext context) {
  print('STATUS AWAL');
  print(dataStatus);

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
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
  bool isExpanded;
  String timeRange;
  Function(bool) onChange;
  AgendaCardAnimateNow({
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
    var _isExpanded = widget.isExpanded;
    var _data = widget.data;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
            widget.onChange(_isExpanded);
          },
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            duration: Duration(milliseconds: 300),
            child: _isExpanded
                ? FocusAgendaDetailCard(
                    customer: _data.customer.company,
                    title: _data.title,
                    desc: _data.desc,
                    date: formatDateText(_data.dueDate),
                    rangeTime: widget.timeRange,
                    priority: _data.priority.name,
                    callbak: () {
                      _updateAgenda(_data.status, _data.id, context);
                    },
                  )
                : AgendaNow(
                    desc: _data.desc,
                    endTime: _data.endTime,
                    startTime: _data.startTime,
                    title: _data.title,
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
  bool isExpanded;
  String timeRange;
  Function(bool) onChange;
  AgendaCardAnimate({
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
  @override
  Widget build(BuildContext context) {
    var _isExpanded = widget.isExpanded;
    var _data = widget.data;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print('CARD EXPANDED');
            setState(() {
              // Toggle the expansion state
              _isExpanded = !_isExpanded;
            });
            widget.onChange(_isExpanded);
          },
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            duration: Duration(milliseconds: 300),
            child: widget.isExpanded
                ? FocusAgendaDetailCard(
                    customer: _data.customer.company,
                    title: _data.title,
                    desc: _data.desc,
                    date: formatDateText(_data.dueDate),
                    rangeTime: widget.timeRange,
                    priority: _data.priority.name,
                    callbak: () {
                      _updateAgenda(_data.status, _data.id, context);
                    },
                  )
                : AgendaCard(
                    desc: _data.desc,
                    endTime: _data.endTime,
                    startTime: _data.startTime,
                    title: _data.title,
                    color: getPriorityColor(_data.priority.name),
                  ),
          ),
        ),
        spacerHeight(12),
      ],
    );
  }
}
