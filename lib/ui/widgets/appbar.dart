import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/CRMTrack.png', width: 79),
          const Icon(
            Icons.notifications_none,
            size: 24,
          ),
        ],
      ),
    );
  }
}
