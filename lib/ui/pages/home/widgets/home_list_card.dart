import 'package:flutter/material.dart';

class HomeListCard extends StatefulWidget {
  final String type;
  final String title;
  final bool isCompleted;
  final String time;

  const HomeListCard({
    super.key,
    required this.type,
    required this.title,
    this.isCompleted = false,
    required this.time,
  });

  @override
  State<HomeListCard> createState() => _HomeListCardState();
}

class _HomeListCardState extends State<HomeListCard> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: const BoxDecoration(
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: widget.type == 'Meeting'
                      ? const Color.fromRGBO(241, 69, 72, 1)
                      : const Color.fromRGBO(1, 186, 239, 1),
                ),
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
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.time,
                    style: const TextStyle(
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
                        color: const Color.fromRGBO(201, 233, 218, 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: const Text(
                        'Completed',
                        style: TextStyle(
                            color: Color.fromRGBO(25, 135, 84, 1),
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                : Checkbox(
                    value: isCompleted,
                    onChanged: (bool? value) {
                      setState(() {
                        isCompleted = value!;
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
