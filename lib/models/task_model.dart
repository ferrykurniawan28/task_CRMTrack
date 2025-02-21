class TaskModel {
  final String title;
  final String type;
  final bool isCompleted;
  final String time;

  TaskModel({
    required this.title,
    required this.type,
    required this.isCompleted,
    required this.time,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      type: json['type'],
      isCompleted: json['isCompleted'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'isCompleted': isCompleted,
      'time': time,
    };
  }
}
