import 'package:timeline_tile/timeline_tile.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkflowDetail extends StatelessWidget {
  final Workflow workflow;
  const WorkflowDetail({super.key, required this.workflow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workflow.workflow),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(8),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
              foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.white,
            onSelected: (value) {
              if (value == 'edit') {
                // Handle edit action
              } else if (value == 'drop') {
                // Handle delete action
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'detail',
                child: Row(
                  children: [
                    const Icon(Icons.visibility_outlined, color: Colors.black),
                    spacerWidth(10),
                    const Text('Detail'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'drop',
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.black,
                    ),
                    spacerWidth(10),
                    const Text('Drop'),
                  ],
                ),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          spacerWidth(10),
        ],
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: ListView(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Workflow',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE6E6E6),
                      ),
                    ),
                    spacerHeight(6),
                    Text(
                      workflow.workflow,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                spacerHeight(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status Workflow',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE6E6E6),
                      ),
                    ),
                    spacerHeight(6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: switch (workflow.status) {
                          WorkflowStatus.completed => const Color(0xFFC9E9DA),
                          WorkflowStatus.failed => const Color(0xFFFFBDC3),
                          WorkflowStatus.onGoing => const Color(0xFFFFF1C8),
                        },
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        workflowStatusToString(workflow.status),
                        style: TextStyle(
                          fontSize: 10,
                          color: switch (workflow.status) {
                            WorkflowStatus.completed => const Color(0xFF198754),
                            WorkflowStatus.failed => const Color(0xFFB02A37),
                            WorkflowStatus.onGoing => const Color(0xFFFFC107),
                          },
                          // fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
                spacerHeight(16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Last Update',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFE6E6E6),
                            ),
                          ),
                          spacerHeight(6),
                          Row(
                            children: [
                              Image.asset('assets/icon/calendar2-day.png',
                                  color: Colors.white),
                              spacerWidth(10),
                              Text(
                                DateFormat('hh.mm  dd MMM yyyy')
                                    .format(workflow.lastUpdated),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Stage',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFE6E6E6),
                            ),
                          ),
                          spacerHeight(6),
                          Row(
                            children: [
                              Image.asset('assets/icon/bezier2.png',
                                  color: Colors.white),
                              spacerWidth(4),
                              Text(
                                workflowStageToString(workflow.stage),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          spacerHeight(16),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workflow.staging.length,
            itemBuilder: (context, index) {
              List<Staging> staging = workflow.staging.reversed.toList();
              final isFirst = index == 0;
              final isLast = index == staging.length - 1;

              return TimelineTile(
                isFirst: isFirst,
                isLast: isLast,
                indicatorStyle: IndicatorStyle(
                  indicatorXY: 0.0,
                  width: 36,
                  height: 36,
                  color: const Color(0xFFCDDFEE),
                  indicator: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: (workflow.status != WorkflowStatus.completed &&
                              index == 0)
                          ? const Color(0xFFD1FFEA)
                          : const Color(0xFFCDDFEE),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                        (workflow.status != WorkflowStatus.completed &&
                                index == 0)
                            ? 'assets/icon/patch-minus-fill.png'
                            : 'assets/icon/patch-check-fill.png'),
                  ),
                ),
                beforeLineStyle:
                    const LineStyle(color: Colors.blue, thickness: 1),
                afterLineStyle:
                    const LineStyle(color: Colors.blue, thickness: 1),
                endChild: Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/workflow/stage',
                        arguments: staging[index],
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(fontSize: 14),
                            children: [
                              TextSpan(
                                text: "${staging[index].name} ",
                                style: TextStyle(fontWeight: medium),
                              ),
                              const TextSpan(
                                text: 'Created a step ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextSpan(
                                text:
                                    workflowStageToString(staging[index].stage),
                                style: TextStyle(fontWeight: medium),
                              ),
                            ],
                          ),
                        ),
                        spacerHeight(2),
                        Text(
                          DateFormat('hh.mm  dd MMM yyyy')
                              .format(staging[index].lastUpdated),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        spacerHeight(10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: staging[index]
                                .pipelineCreated
                                .map(
                                  (pipeline) => Container(
                                    margin: const EdgeInsets.only(bottom: 22),
                                    height: 36,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          (workflow.status !=
                                                      WorkflowStatus
                                                          .completed &&
                                                  index == 0)
                                              ? 'assets/icon/patch-minus-fill.png'
                                              : 'assets/icon/patch-check-fill.png',
                                          color:
                                              (workflow.status !=
                                                          WorkflowStatus
                                                              .completed &&
                                                      index == 0 &&
                                                      (staging[index]
                                                              .pipelineCreated
                                                              .length >
                                                          1) &&
                                                      pipeline ==
                                                          staging[index]
                                                              .pipelineCreated
                                                              .last)
                                                  ? Colors.grey
                                                  : null,
                                        ),
                                        spacerWidth(4),
                                        Text.rich(
                                          TextSpan(
                                            style:
                                                const TextStyle(fontSize: 14),
                                            children: [
                                              const TextSpan(
                                                text: 'Pipeline ',
                                              ),
                                              const TextSpan(
                                                text: 'Created on ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              TextSpan(
                                                text: DateFormat('dd MMM yyyy')
                                                    .format(pipeline),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 16),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // TimelineTile(axis: TimelineAxis.horizontal)
        ],
      ),
    );
  }
}
