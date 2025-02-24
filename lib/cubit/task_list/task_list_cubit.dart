import 'package:bloc/bloc.dart';
import 'package:crm_track/models/task_detail.dart';
import 'package:meta/meta.dart';

part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit() : super(TaskListInitial());

  void getTasks() async {
    emit(TaskListLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final tasks = dummyTask;
      emit(TaskListLoaded(tasks));
    } catch (e) {
      emit(TaskListError(e.toString()));
    }
  }

  void clearTasks() {
    emit(TaskListInitial());
  }
}
