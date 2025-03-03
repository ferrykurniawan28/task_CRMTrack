class OpportunityModel {
  final String id;
  final String opprtunity;
  final String description;
  final DateTime closeDate;
  final int amount;
  final OpportunityType type;
  OpportunityStage stage;
  final LeadSource leadSource;
  final int probability;
  final String createdBy;
  final String lastModifiedBy;
  final CustomerOpportunity customer;

  OpportunityModel({
    required this.id,
    required this.opprtunity,
    required this.description,
    required this.closeDate,
    required this.amount,
    required this.type,
    required this.stage,
    required this.leadSource,
    required this.probability,
    required this.createdBy,
    required this.lastModifiedBy,
    required this.customer,
  });
}

enum OpportunityStage {
  qualification,
  meeting,
  proposal,
  negotiation,
  closedWon,
  closedLost,
}

String opportunityStageToString(OpportunityStage stage) {
  switch (stage) {
    case OpportunityStage.qualification:
      return 'Qualification';
    case OpportunityStage.meeting:
      return 'Meeting';
    case OpportunityStage.proposal:
      return 'Proposal';
    case OpportunityStage.negotiation:
      return 'Negotiation';
    case OpportunityStage.closedWon:
      return 'Closed Won';
    case OpportunityStage.closedLost:
      return 'Closed Lost';
  }
}

enum OpportunityType {
  newBusiness,
  existingBusiness,
}

String opportunityTypeToString(OpportunityType type) {
  switch (type) {
    case OpportunityType.newBusiness:
      return 'New Business';
    case OpportunityType.existingBusiness:
      return 'Existing Business';
  }
}

enum LeadSource {
  advertisement,
  employeeReferral,
  externalReferral,
  inStore,
  onsite,
  social,
  tradeShow,
  web,
  wordOfMouth,
  other,
}

String leadSourceToString(LeadSource source) {
  switch (source) {
    case LeadSource.advertisement:
      return 'Advertisement';
    case LeadSource.employeeReferral:
      return 'Employee Referral';
    case LeadSource.externalReferral:
      return 'External Referral';
    case LeadSource.inStore:
      return 'In Store';
    case LeadSource.onsite:
      return 'Onsite';
    case LeadSource.social:
      return 'Social';
    case LeadSource.tradeShow:
      return 'Trade Show';
    case LeadSource.web:
      return 'Web';
    case LeadSource.wordOfMouth:
      return 'Word of Mouth';
    case LeadSource.other:
      return 'Other';
  }
}

class CustomerOpportunity {
  int id;
  String name;
  String email;
  int phone;
  String jobTitle;
  String company;

  CustomerOpportunity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.jobTitle,
    required this.company,
  });
}

List<OpportunityModel> opportunityList = [
  OpportunityModel(
    id: '1',
    opprtunity: 'New Website Development',
    description:
        'Develop a new website for the client. lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    closeDate: DateTime.now().add(const Duration(days: 30)),
    amount: 5000,
    type: OpportunityType.newBusiness,
    stage: OpportunityStage.qualification,
    leadSource: LeadSource.web,
    probability: 70,
    createdBy: 'John Doe',
    lastModifiedBy: 'Jane Smith',
    customer: CustomerOpportunity(
      id: 1,
      name: 'Acme Corp',
      email: 'contact@acme.com',
      phone: 1234567890,
      jobTitle: 'CEO',
      company: 'Acme Corp',
    ),
  ),
  OpportunityModel(
    id: '2',
    opprtunity: 'Mobile App Development',
    description: 'Develop a mobile app for the client',
    closeDate: DateTime.now().add(const Duration(days: 60)),
    amount: 10000,
    type: OpportunityType.existingBusiness,
    stage: OpportunityStage.proposal,
    leadSource: LeadSource.social,
    probability: 50,
    createdBy: 'John Doe',
    lastModifiedBy: 'Jane Smith',
    customer: CustomerOpportunity(
      id: 2,
      name: 'Beta Ltd',
      email: 'contact@beta.com',
      phone: 9876543210,
      jobTitle: 'CTO',
      company: 'Beta Ltd',
    ),
  ),
];
