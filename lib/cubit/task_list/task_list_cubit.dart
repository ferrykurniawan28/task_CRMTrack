import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';

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

  void addTask(TaskDetail task) {
    if (state is TaskListLoaded) {
      final tasks = (state as TaskListLoaded).tasks;
      tasks.add(task);
      emit(TaskListLoaded(tasks));
    }
  }

  void updateTask(TaskDetail task) {
    if (state is TaskListLoaded) {
      final tasks = (state as TaskListLoaded).tasks;
      final index = tasks.indexWhere((element) => element.id == task.id);
      tasks[index] = task;
      emit(TaskListLoaded(tasks));
    }
  }
}
