class ListActivity {
  String user;
  ActivityType type;
  String description;
  String location;
  DateTime date;
  bool isRead;

  ListActivity({
    required this.user,
    required this.type,
    required this.description,
    required this.location,
    required this.date,
    required this.isRead,
  });
}

enum ActivityType {
  created,
  updated,
  edited,
}

String activityTypeToString(ActivityType type) {
  switch (type) {
    case ActivityType.created:
      return 'created a step';
    case ActivityType.updated:
      return 'update in step';
    case ActivityType.edited:
      return 'edite in step';
  }
}

List<ListActivity> listActivity = [
  ListActivity(
    user: 'John Doe',
    type: ActivityType.created,
    description: 'Last Staging',
    location: 'Exapmle Workflow',
    date: DateTime.now(),
    isRead: false,
  ),
  ListActivity(
    user: 'Jane Smith',
    type: ActivityType.updated,
    description: 'Last Staging',
    location: 'Exapmle Workflow',
    date: DateTime.now().subtract(const Duration(days: 1)),
    isRead: true,
  ),
  ListActivity(
    user: 'Alice Johnson',
    type: ActivityType.edited,
    description: 'Last Staging',
    location: 'Exapmle Workflow',
    date: DateTime.now().subtract(const Duration(days: 2)),
    isRead: false,
  ),
];
