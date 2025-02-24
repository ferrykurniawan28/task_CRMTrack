import 'dart:ui';

import 'package:crm_track/ui/pages/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationCenter(),
                ),
              );
            },
            child: const Icon(
              Icons.notifications_none,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
