import 'package:crm_track/helpers/filter.dart';
import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';

class HeaderList extends StatelessWidget {
  final int totalData;
  DateTime date;
  HeaderList({super.key, required this.totalData, required this.date});

  @override
  Widget build(BuildContext context) {
    print('TANGGAL YANG DI DAPAT HEADER LIST');
    print(formatDateText(date));
    print('TANGGAL NOW');
    print(formatDateText(DateTime.now()));
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: kColorBrown),
        color: kColorLightBrown,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatDateText(date) == formatDateText(DateTime.now())
                ? 'Today'
                : formatDateText(date),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            totalData.toString() + ' Tasks',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
