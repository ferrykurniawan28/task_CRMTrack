// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../../helpers/helpers.dart';
import '../../../../../theme/colors.dart';

class CustomCalendarToday extends StatelessWidget {
  final String date;
  final String dayName;
  const CustomCalendarToday(
      {super.key, required this.date, required this.dayName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.red[200],
        border: Border.all(color: primaryColor, width: 1),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              spacerHeight(6),
              SizedBox(
                width: 25,
                child: Text(
                  dayName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomCalendarSelected extends StatelessWidget {
  final String date;
  final String dayName;
  const CustomCalendarSelected(
      {super.key, required this.date, required this.dayName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: primaryColor,
        border: Border.all(color: primaryColor, width: 1),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              spacerHeight(6),
              SizedBox(
                width: 25,
                child: Text(
                  dayName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomCalendar extends StatelessWidget {
  final String date;
  final String dayName;
  const CustomCalendar({super.key, required this.date, required this.dayName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(color: kColorRed, width: 1),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                date,
                style: TextStyle(
                  color: kColorRed,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              spacerHeight(6),
              SizedBox(
                width: 25,
                child: Text(
                  dayName,
                  style: TextStyle(
                    color: kColorRed,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
