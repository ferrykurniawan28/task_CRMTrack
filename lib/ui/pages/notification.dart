import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/notification/notification_cubit.dart';
import '../widgets/notifcations/notification_card.dart';

class NotificationCenter extends StatelessWidget {
  const NotificationCenter({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotificationCubit>(context).getNotifications();
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
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoaded) {
            return ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                  child: SizedBox(
                    height: 37,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
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
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return notificationCard(notification);
                  },
                )
              ],
            );
          }
          if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
