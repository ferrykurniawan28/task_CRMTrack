import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';

class HomeListCard extends StatefulWidget {
  final String? type;
  final String? title;
  bool? isCompleted;
  final String? time;
  HomeListCard({
    super.key,
    required this.type,
    required this.title,
    required this.isCompleted,
    required this.time,
  });

  @override
  State<HomeListCard> createState() => _HomeListCardState();
}

class _HomeListCardState extends State<HomeListCard> {
  @override
  Widget build(BuildContext context) {
    bool isCompleted = widget.isCompleted!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Color.fromRGBO(249, 250, 251, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: widget.type == 'Meeting'
                    ? Image.asset(
                        'assets/icon/telephone.png',
                        height: 24,
                        width: 24,
                      )
                    : Image.asset(
                        'assets/icon/chat-quote.png',
                        height: 24,
                        width: 24,
                      ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: widget.type == 'Meeting'
                      ? Color.fromRGBO(241, 69, 72, 1)
                      : Color.fromRGBO(1, 186, 239, 1),
                ),
              ),
              spacerWidth(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title ?? '-',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.time ?? '-',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            child: isCompleted
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isCompleted = !isCompleted;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color.fromRGBO(201, 233, 218, 1),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        'Completed',
                        style: TextStyle(
                            color: Color.fromRGBO(25, 135, 84, 1),
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                : Checkbox(
                    value: widget.isCompleted,
                    onChanged: (bool? value) {
                      setState(() {
                        widget.isCompleted = value!;
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
