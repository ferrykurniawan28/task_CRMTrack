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
  final Function()? callbak;

  const FocusAgendaDetailCard({
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: getPriorityColor(priority),
        ),
        boxShadow: const [
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
              const SizedBox(width: 11),
              Text(
                customer,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              Text(
                desc,
                style: const TextStyle(
                  color: kColorGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icon/calendar-date.png'),
                  const SizedBox(width: 10),
                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icon/clock-history.png'),
                      const SizedBox(width: 10),
                      Text(
                        rangeTime,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon/lightning-fill.png',
                        color: priority == 'high'
                            ? kColorRed
                            : priority == 'low'
                                ? kColorGreen
                                : kColorLightBlue,
                      ),
                      const SizedBox(width: 10),
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
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: callbak,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: getPriorityColor(priority),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
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
