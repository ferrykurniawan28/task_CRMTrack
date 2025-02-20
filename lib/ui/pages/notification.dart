import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/models.dart';
import 'package:flutter/material.dart';

class NotificationCenter extends StatelessWidget {
  const NotificationCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
            child: SizedBox(
              height: 37,
              child: ListView.builder(
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE6E6E6),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Cat ${index + 1}',
                        style: const TextStyle(
                          color: Color(0xFF899197),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
            child: Text(
              'Latest',
              style: TextStyle(
                color: const Color(0xFF141619),
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummyNotification.length,
            itemBuilder: (context, index) {
              final notification = dummyNotification[index];
              return notificationCard(notification);
            },
          )
        ],
      ),
    );
  }
}

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
                      CustomSpacer.width(8),
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
                      CustomSpacer.width(8),
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
                      CustomSpacer.width(8),
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
