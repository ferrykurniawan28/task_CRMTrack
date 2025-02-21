part of 'models.dart';

class Notifications {
  final String? title;
  final String? message;
  final String? imageUrl;
  final DateTime? createdAt;
  final NotificationType? type;

  Notifications({
    this.title,
    this.message,
    this.imageUrl,
    this.createdAt,
    this.type,
  });
}

enum NotificationType {
  info,
  warning,
  error,
}

String timeAgo(DateTime dateTime) {
  final Duration difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days';
  } else {
    return '${(difference.inDays / 7).floor()} weeks';
  }
}

List<Notifications> dummyNotification = [
  Notifications(
    title: 'New Notification',
    message: 'You have a new notification',
    imageUrl: 'https://via.placeholder.com/150',
    createdAt: DateTime.now(),
    type: NotificationType.info,
  ),
  Notifications(
    title: 'Warning Notification',
    message: 'You have a warning notification',
    imageUrl: 'https://via.placeholder.com/150',
    createdAt: DateTime.now(),
    type: NotificationType.warning,
  ),
  Notifications(
    title: 'Error Notification',
    message: 'You have an error notification',
    imageUrl: 'https://via.placeholder.com/150',
    createdAt: DateTime.now(),
    type: NotificationType.error,
  ),
  Notifications(
    title: 'New Notification',
    message: 'You have a new notification',
    imageUrl: 'https://via.placeholder.com/150',
    createdAt: DateTime.now(),
    type: NotificationType.info,
  ),
  Notifications(
    title: 'New Notification',
    message: 'You have a new notification',
    imageUrl: 'https://via.placeholder.com/150',
    createdAt: DateTime.now(),
    type: NotificationType.info,
  ),
  Notifications(
    title: 'New Notification',
    message: 'You have a new notification',
    imageUrl: 'https://via.placeholder.com/150',
    createdAt: DateTime.now(),
    type: NotificationType.info,
  ),
  Notifications(
    title: 'New Notification',
    message: 'You have a new notification',
    imageUrl: 'https://via.placeholder.com/150',
    createdAt: DateTime.now(),
    type: NotificationType.info,
  ),
  Notifications(
    title: 'New Notification',
    message: 'You have a new notification',
    imageUrl: 'https://via.placeholder.com/150',
    createdAt: DateTime.now(),
    type: NotificationType.info,
  ),
];
