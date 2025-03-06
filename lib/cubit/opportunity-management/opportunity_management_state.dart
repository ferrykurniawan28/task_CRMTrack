part of 'opportunity_management_cubit.dart';

@immutable
sealed class OpportunityManagementState {}

final class OpportunityManagementInitial extends OpportunityManagementState {}

final class OpportunityManagementLoading extends OpportunityManagementState {}

final class OpportunityManagementLoaded extends OpportunityManagementState {
  final List<OpportunityModel> opportunities;

  OpportunityManagementLoaded(this.opportunities);
}

final class OpportunityManagementError extends OpportunityManagementState {
  final String message;

  OpportunityManagementError(this.message);
}
