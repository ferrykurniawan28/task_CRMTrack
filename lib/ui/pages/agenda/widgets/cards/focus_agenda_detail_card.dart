import 'package:crm_track/helpers/filter.dart';
import 'package:flutter/material.dart';
import '../../../../../helpers/helpers.dart';
import '../../../../../theme/colors.dart';

class FocusAgendaDetailCard extends StatelessWidget {
  final String customer;
  final String title;
  final String desc;
  final String date;
  final String rangeTime;
  final String priority;
  Function()? callbak;
  FocusAgendaDetailCard({
    super.key,
    required this.customer,
    required this.title,
    required this.desc,
    required this.date,
    required this.rangeTime,
    required this.priority,
    required this.callbak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: getPriorityColor(priority),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            spreadRadius: -2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset('assets/images/Avatar.png'),
              ),
              spacerWidth(11),
              Text(
                customer,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          spacerHeight(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              Text(
                desc,
                style: TextStyle(
                  color: kColorGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          spacerHeight(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Image.asset('assets/icon/calendar-date.png'),
                    spacerWidth(10),
                    Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.asset('assets/icon/clock-history.png'),
                          spacerWidth(10),
                          Text(
                            rangeTime,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    spacerWidth(20),
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icon/lightning-fill.png',
                            color: priority == 'high'
                                ? kColorRed
                                : priority == 'low'
                                    ? kColorGreen
                                    : kColorLightBlue,
                          ),
                          spacerWidth(10),
                          Text(
                            priority,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: priority == 'high'
                                  ? kColorRed
                                  : priority == 'low'
                                      ? kColorGreen
                                      : kColorLightBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          spacerHeight(12),
          GestureDetector(
            onTap: callbak,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: getPriorityColor(priority),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Update Status',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
