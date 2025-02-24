part of 'task_list_cubit.dart';

@immutable
sealed class TaskListState {}

final class TaskListInitial extends TaskListState {}

final class TaskListLoading extends TaskListState {}

final class TaskListLoaded extends TaskListState {
  final List<TaskDetail> tasks;

  TaskListLoaded(this.tasks);
}

final class TaskListError extends TaskListState {
  final String message;

  TaskListError(this.message);
}
