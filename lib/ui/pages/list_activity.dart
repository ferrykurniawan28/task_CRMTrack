import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/list_activity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListActivityScreen extends StatelessWidget {
  const ListActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Activity'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          spacerHeight(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search Activity',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF899197),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF899197),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE6E6E6),
                  ),
                ),
              ),
            ),
          ),
          spacerHeight(12),
          ListView.builder(
            itemCount: listActivity.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return listActivityCard(listActivity[index]);
            },
          ),
        ],
      ),
    );
  }
}

Widget listActivityCard(ListActivity listActivity) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
    color: listActivity.isRead ? Colors.transparent : Colors.white,
    child: Row(
      children: [
        Image.asset(listActivity.isRead
            ? 'assets/icon/Point-read.png'
            : 'assets/icon/Point.png'),
        spacerWidth(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${listActivity.user} ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: activityTypeToString(listActivity.type)),
                    TextSpan(
                      text: listActivity.description,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: 'at'),
                    TextSpan(
                      text: listActivity.location,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
              Text(
                DateFormat('hh.mm dd MM y').format(listActivity.date),
                style: const TextStyle(
                  color: Color(0xFF899197),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
