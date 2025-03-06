import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/CRMTrack.png', width: 79),
          GestureDetector(
            onTap: () => Modular.to.pushNamed('/notification-center'),
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
