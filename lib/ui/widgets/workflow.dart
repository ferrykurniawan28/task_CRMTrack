// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';

class WorkflowWidget extends StatefulWidget {
  const WorkflowWidget({super.key});

  @override
  State<WorkflowWidget> createState() => _WorkflowWidgetState();
}

class _WorkflowWidgetState extends State<WorkflowWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(221, 201, 169, 1),
          ),
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(255, 251, 243, 1),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Workflow 1',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
            spacerHeight(12),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  WorkFlowCard(
                    number: '12',
                    title: 'On going',
                    color: Color.fromRGBO(86, 209, 244, 1),
                  ),
                  WorkFlowCard(
                    number: '8',
                    title: 'Complete',
                    color: Color.fromRGBO(71, 159, 118, 1),
                  ),
                  WorkFlowCard(
                    number: '1',
                    title: 'Failed',
                    color: Color.fromRGBO(241, 69, 72, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkFlowCard extends StatelessWidget {
  final String number;
  final String title;
  final Color color;
  const WorkFlowCard({
    super.key,
    required this.number,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      width: 106,
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
