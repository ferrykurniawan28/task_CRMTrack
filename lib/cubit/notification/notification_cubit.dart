import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void getNotifications() async {
    emit(NotificationLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      emit(NotificationLoaded(dummyNotification));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  void clearNotifications() {
    emit(NotificationInitial());
  }
}
