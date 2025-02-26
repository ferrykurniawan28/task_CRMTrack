part of 'models.dart';

class Workflow {
  int id;
  String workflow;
  DateTime lastUpdated;
  WorkflowStatus status;
  WorkflowStage stage;
  List<Staging> staging;

  Workflow({
    required this.id,
    required this.workflow,
    required this.lastUpdated,
    required this.status,
    required this.stage,
    required this.staging,
  });
}

enum WorkflowStatus { onGoing, completed, failed }

String workflowStatusToString(WorkflowStatus status) {
  switch (status) {
    case WorkflowStatus.onGoing:
      return 'On Going';
    case WorkflowStatus.completed:
      return 'Completed';
    case WorkflowStatus.failed:
      return 'Failed';
  }
}

enum WorkflowStage { first, second, last }

String workflowStageToString(WorkflowStage stage) {
  switch (stage) {
    case WorkflowStage.first:
      return 'First Staging';
    case WorkflowStage.second:
      return 'Second Staging';
    case WorkflowStage.last:
      return 'Last Staging';
  }
}

class Staging {
  String name;
  WorkflowStage stage;
  DateTime lastUpdated;
  List<DateTime> pipelineCreated;
  String? title;
  String? address;
  double? lat;
  double? long;
  List<String>? images;
  List<String>? videos;
  List<String>? documents;
  Uint8List? signature;
  bool isCompleted = false;

  Staging({
    required this.name,
    required this.stage,
    required this.lastUpdated,
    required this.pipelineCreated,
    this.title,
    this.address,
    this.lat,
    this.long,
    this.images,
    this.videos,
    this.documents,
    this.signature,
    this.isCompleted = false,
  });
}

List<Workflow> dummyWorkflow = [
  Workflow(
    id: 1,
    workflow: 'Workflow 1',
    lastUpdated: DateTime.now(),
    status: WorkflowStatus.onGoing,
    stage: WorkflowStage.first,
    staging: [
      Staging(
        name: 'Superadmin',
        stage: WorkflowStage.first,
        lastUpdated: DateTime.now(),
        pipelineCreated: [DateTime.now(), DateTime.now()],
      ),
      Staging(
        name: 'Superadmin',
        stage: WorkflowStage.second,
        lastUpdated: DateTime.now(),
        pipelineCreated: [DateTime.now(), DateTime.now()],
      ),
      Staging(
        name: 'Superadmin',
        stage: WorkflowStage.last,
        lastUpdated: DateTime.now(),
        pipelineCreated: [DateTime.now(), DateTime.now()],
      ),
    ],
  ),
  Workflow(
    id: 2,
    workflow: 'Workflow 2',
    lastUpdated: DateTime.now(),
    status: WorkflowStatus.completed,
    stage: WorkflowStage.last,
    staging: [
      Staging(
        name: 'Superadmin',
        stage: WorkflowStage.first,
        lastUpdated: DateTime.now(),
        pipelineCreated: [DateTime.now(), DateTime.now()],
      ),
      Staging(
        name: 'Superadmin',
        stage: WorkflowStage.second,
        lastUpdated: DateTime.now(),
        pipelineCreated: [DateTime.now(), DateTime.now()],
      ),
      Staging(
        name: 'Superadmin',
        stage: WorkflowStage.last,
        lastUpdated: DateTime.now(),
        pipelineCreated: [DateTime.now(), DateTime.now()],
      ),
    ],
  ),
  Workflow(
    id: 3,
    workflow: 'Workflow 3',
    lastUpdated: DateTime.now(),
    status: WorkflowStatus.failed,
    stage: WorkflowStage.second,
    staging: [
      Staging(
        name: 'Superadmin',
        stage: WorkflowStage.first,
        lastUpdated: DateTime.now(),
        pipelineCreated: [DateTime.now(), DateTime.now()],
      ),
      Staging(
        name: 'Superadmin',
        stage: WorkflowStage.second,
        lastUpdated: DateTime.now(),
        pipelineCreated: [DateTime.now(), DateTime.now()],
      ),
      Staging(
        name: 'Superadmin',
        stage: WorkflowStage.last,
        lastUpdated: DateTime.now(),
        pipelineCreated: [DateTime.now(), DateTime.now()],
      ),
    ],
  ),
];
