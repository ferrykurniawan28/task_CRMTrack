import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/models.dart';
import 'package:crm_track/ui/widgets/task_list/task_list_filter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkFlowList extends StatefulWidget {
  const WorkFlowList({super.key});

  @override
  State<WorkFlowList> createState() => _WorkFlowListState();
}

class _WorkFlowListState extends State<WorkFlowList> {
  final List<String> workflowFilter = [
    'All',
    'On Going',
    'Completed',
    'Failed',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workflow'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: ListView(
        children: [
          spacerHeight(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                hintText: 'Search Workflow',
                hintStyle: const TextStyle(
                  color: Color(0xFF899197),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFF899197),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          spacerHeight(16),
          FilterWidget(taskFilter: workflowFilter, onSelected: (int int) {}),
          spacerHeight(16),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummyWorkflow.length,
            itemBuilder: (context, index) {
              final Workflow workflow = dummyWorkflow[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/workflow/detail',
                  arguments: workflow,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  margin: const EdgeInsets.only(
                    bottom: 31,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icon/bezier2.png'),
                          spacerWidth(10),
                          Text(
                            workflowStageToString(workflow.stage),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4D5154),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: switch (workflow.status) {
                                WorkflowStatus.completed =>
                                  const Color(0xFFC9E9DA),
                                WorkflowStatus.failed =>
                                  const Color(0xFFFFBDC3),
                                WorkflowStatus.onGoing =>
                                  const Color(0xFFFFF1C8),
                              },
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              workflowStatusToString(workflow.status),
                              style: TextStyle(
                                color: switch (workflow.status) {
                                  WorkflowStatus.completed =>
                                    const Color(0xFF198754),
                                  WorkflowStatus.failed =>
                                    const Color(0xFFB02A37),
                                  WorkflowStatus.onGoing =>
                                    const Color(0xFFFFC107),
                                },
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      spacerHeight(8),
                      Text(
                        workflow.workflow,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      spacerHeight(8),
                      Text.rich(
                        TextSpan(
                          text: 'Last Update ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7A7C7F),
                          ),
                          children: [
                            TextSpan(
                              text: DateFormat('hh.mm  dd MMM yyyy')
                                  .format(workflow.lastUpdated),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1A1E21),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
