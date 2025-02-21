import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class TaskFilterWidget extends StatefulWidget {
  final List<String> taskFilter;
  final Function(int) onSelected;

  const TaskFilterWidget({
    super.key,
    required this.taskFilter,
    required this.onSelected,
  });

  @override
  State<TaskFilterWidget> createState() => _TaskFilterWidgetState();
}

class _TaskFilterWidgetState extends State<TaskFilterWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 37,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.taskFilter.length,
          itemBuilder: (context, index) {
            bool isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onSelected(index);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected ? primaryColor : Colors.white,
                  border: Border.all(
                    color: isSelected ? primaryColor : const Color(0xFFE6E6E6),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.taskFilter[index],
                    style: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xFF899197),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
