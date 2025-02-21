import 'package:flutter/material.dart';

class HomeListCard extends StatelessWidget {
  final String type;
  final String title;
  final bool isCompleted;
  final String time;
  const HomeListCard({
    super.key,
    required this.type,
    required this.title,
    required this.isCompleted,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color.fromRGBO(249, 250, 251, 1),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: type == 'Meeting'
                    ? Image.asset(
                        'assets/icon/telephone.png',
                      )
                    : Image.asset(
                        'assets/icon/chat-quote.png',
                      ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: type == 'Meeting'
                      ? Color.fromRGBO(241, 69, 72, 1)
                      : Color.fromRGBO(1, 186, 239, 1),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
