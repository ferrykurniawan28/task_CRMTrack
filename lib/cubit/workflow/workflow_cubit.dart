import 'package:bloc/bloc.dart';
import 'package:crm_track/models/models.dart';
import 'package:meta/meta.dart';

part 'workflow_state.dart';

class WorkflowCubit extends Cubit<WorkflowState> {
  WorkflowCubit() : super(WorkflowInitial());

  void getWorkflows() {
    emit(WorkflowLoading());
    try {
      final List<Workflow> workflows = dummyWorkflow;
      emit(WorkflowLoaded(workflows));
    } catch (e) {
      emit(WorkflowError(e.toString()));
    }
  }

  void filterWorkflows(String filter) {
    emit(WorkflowLoading());
    try {
      final List<Workflow> workflows = dummyWorkflow
          .where((workflow) =>
              workflowStatusToString(workflow.status).toLowerCase() ==
              filter.toLowerCase())
          .toList();
      emit(WorkflowLoaded(workflows));
    } catch (e) {
      emit(WorkflowError(e.toString()));
    }
  }

  void updateStaging(Workflow workflow, Staging staging) {
    emit(WorkflowLoading());
    try {
      final List<Workflow> workflows = dummyWorkflow
          .map((wf) => wf.id == workflow.id
              ? Workflow(
                  id: wf.id,
                  workflow: wf.workflow,
                  lastUpdated: wf.lastUpdated,
                  status: wf.status,
                  stage: wf.stage,
                  staging: wf.staging
                      .map((st) => st.name == staging.name
                          ? Staging(
                              name: st.name,
                              stage: st.stage,
                              lastUpdated: DateTime.now(),
                              pipelineCreated: st.pipelineCreated,
                              title: st.title,
                              address: st.address,
                              lat: st.lat,
                              long: st.long,
                              images: st.images,
                              videos: st.videos,
                              documents: st.documents,
                              signature: st.signature,
                              isCompleted: true,
                            )
                          : st)
                      .toList(),
                )
              : wf)
          .toList();
      emit(WorkflowLoaded(workflows));
    } catch (e) {
      emit(WorkflowError(e.toString()));
    }
  }
}
