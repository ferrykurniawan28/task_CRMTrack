import 'package:bloc/bloc.dart';
import 'package:crm_track/models/opportunity_model.dart';
import 'package:meta/meta.dart';

part 'opportunity_management_state.dart';

class OpportunityManagementCubit extends Cubit<OpportunityManagementState> {
  OpportunityManagementCubit() : super(OpportunityManagementInitial());

  void fetchOpportunity() async {
    emit(OpportunityManagementLoading());
    try {
      final opportunity = opportunityList;
      emit(OpportunityManagementLoaded(opportunity));
    } catch (e) {
      emit(OpportunityManagementError(e.toString()));
    }
  }

  void clearOpportunity() {
    emit(OpportunityManagementInitial());
  }

  void addOpportunity(OpportunityModel opportunity) {
    if (state is OpportunityManagementLoaded) {
      final opportunities =
          (state as OpportunityManagementLoaded).opportunities;
      opportunities.add(opportunity);
      emit(OpportunityManagementLoaded(opportunities));
    }
  }

  void updateStageOpportunity(OpportunityModel opportunity) {
    if (state is OpportunityManagementLoaded) {
      final opportunities =
          (state as OpportunityManagementLoaded).opportunities;
      final index =
          opportunities.indexWhere((element) => element.id == opportunity.id);
      opportunities[index] = opportunity;
      emit(OpportunityManagementLoaded(opportunities));
    }
  }
}
