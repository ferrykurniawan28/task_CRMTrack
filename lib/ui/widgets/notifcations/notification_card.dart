import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';
import '../../../models/models.dart';

Widget notificationCard(Notifications notification) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: const BoxDecoration(
      color: Color(0xFFFFEBEB),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            switch (notification.type) {
              NotificationType.info => Container(
                  // margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.all(8),
                  // decoration: BoxDecoration(
                  //   color: const Color(0xFFE6F7FF),
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info,
                        color: Color(0xFF00A3FF),
                        size: 16,
                      ),
                      spacerHeight(8),
                      const Text(
                        'Info',
                        style: TextStyle(
                          color: Color(0xFF4D5154),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              NotificationType.warning => Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning,
                        color: Color(0xFFFFA800),
                        size: 16,
                      ),
                      spacerHeight(8),
                      const Text(
                        'Warning',
                        style: TextStyle(
                          color: Color(0xFF4D5154),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              NotificationType.error => Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error,
                        color: Color(0xFFFF4D4D),
                        size: 16,
                      ),
                      spacerHeight(8),
                      const Text(
                        'Error',
                        style: TextStyle(
                          color: Color(0xFF4D5154),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              // TODO: Handle this case.
              null => throw UnimplementedError(),
            },
            const Spacer(),
            Text(
              timeAgo(notification.createdAt!),
              style: const TextStyle(
                color: Color(0xFF4D5154),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 28, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title!,
                style: TextStyle(
                  color: const Color(0xFF141619),
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              Text(
                notification.message!,
                style: const TextStyle(
                  color: Color(0xFF212529),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
