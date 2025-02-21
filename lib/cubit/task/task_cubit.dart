import 'package:bloc/bloc.dart';
import 'package:crm_track/constants/dummy_data.dart';
import 'package:crm_track/models/task_model.dart';
import 'package:meta/meta.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void getTasks() async {
    emit(TaskLoading());
    try {
      final tasks = await tasksData;
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
