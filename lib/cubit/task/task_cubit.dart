import 'package:bloc/bloc.dart';
import 'package:crm_track/constants/dummy_data.dart';
import 'package:crm_track/models/models.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void getTasks() async {
    emit(TaskLoading());
    try {
      final tasks = dummyTask;
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
