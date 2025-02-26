part of 'workflow_cubit.dart';

@immutable
sealed class WorkflowState {}

final class WorkflowInitial extends WorkflowState {}

final class WorkflowLoading extends WorkflowState {}

final class WorkflowLoaded extends WorkflowState {
  final List<Workflow> workflows;

  WorkflowLoaded(this.workflows);
}

final class WorkflowError extends WorkflowState {
  final String message;

  WorkflowError(this.message);
}
