import 'package:flutter/material.dart';
part of 'models.dart';

class TaskDetail {
  int? id;
  String title;
  String? desc;
  DateTime dueDate;
  TaskPriority priority;
  TaskStatus status;
  SenderDetail sender;
  CustomerDetail? customer;
  ProductDetail? product;
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool isComplete;
  String type; //isi 'Follow up' atau 'Meeting'

  TaskDetail({
    this.id,
    required this.title,
    this.desc,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.sender,
    this.customer,
    this.product,
    required this.endTime,
    required this.startTime,
    required this.isComplete,
    required this.type,
  });

  TaskDetail copyWith({TaskStatus? status}) {
    return TaskDetail(
      id: id,
      title: title,
      desc: desc,
      dueDate: dueDate,
      priority: priority,
      status: status ?? this.status,
      sender: sender,
      customer: customer,
      product: product,
      startTime: startTime,
      endTime: endTime,
      isComplete: isComplete,
      type: type,
    );
  }

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return TaskDetail(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      endTime: json['endTime'],
      startTime: json['startTime'],
      isComplete: json['is_complete'],
      type: json['type'],
      dueDate: DateTime.parse(json['dueDate']),
      priority: TaskPriority.values[json['priority']],
      status: TaskStatus.values[json['status']],
      sender: SenderDetail.fromJson(json['sender']),
      customer: CustomerDetail.fromJson(json['customer']),
      product: ProductDetail.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'endTime': endTime,
      'startTime': startTime,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority.index,
      'status': status.index,
      'sender': sender.toJson(),
      'customer': customer!.toJson(),
      'product': product!.toJson(),
    };
  }
}

enum TaskPriority {
  low,
  normal,
  high,
}

enum TaskStatus {
  notStarted,
  inProgress,
  completed,
  deffered,
  other,
}

class SenderDetail {
  String assignor;
  List<String>? cc;

  SenderDetail({
    required this.assignor,
    this.cc,
  });

  factory SenderDetail.fromJson(Map<String, dynamic> json) {
    return SenderDetail(
      assignor: json['assignor'],
      cc: List<String>.from(json['cc']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assignor': assignor,
      'cc': cc,
    };
  }
}

class CustomerDetail {
  String name;
  String email;
  String phone;
  String jobTitle;
  String company;

  CustomerDetail({
    required this.name,
    required this.email,
    required this.phone,
    required this.jobTitle,
    required this.company,
  });

  factory CustomerDetail.fromJson(Map<String, dynamic> json) {
    return CustomerDetail(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      jobTitle: json['jobTitle'],
      company: json['company'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'jobTitle': jobTitle,
      'company': company,
    };
  }
}

class ProductDetail {
  String name;
  String businessLine;

  ProductDetail({
    required this.name,
    required this.businessLine,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      name: json['name'],
      businessLine: json['businessLine'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'businessLine': businessLine,
    };
  }
}

// List<TaskDetail> dummyTask = [
//   TaskDetail(
//     id: 1,
//     title: "Meeting with Client",
//     desc: "Discuss project timeline and deliverables",
//     dueDate: DateTime.now().add(Duration(days: 2)),
//     priority: TaskPriority.high,
//     status: TaskStatus.inProgress,
//     sender: SenderDetail(assignor: "John Doe", cc: ["jane@example.com"]),
//     customer: CustomerDetail(
//       name: "Alice Brown",
//       email: "alice@example.com",
//       phone: "1234567890",
//       jobTitle: "Project Manager",
//       company: "ABC Corp",
//     ),
//     product: ProductDetail(name: "CRM Software", businessLine: "IT Solutions"),
//   ),
//   TaskDetail(
//     id: 2,
//     title: "Code Review",
//     desc: "Review the latest code changes before merging",
//     dueDate: DateTime.now().add(Duration(days: 4)),
//     priority: TaskPriority.normal,
//     status: TaskStatus.notStarted,
//     sender: SenderDetail(assignor: "Jane Smith", cc: ["dev@example.com"]),
//     customer: CustomerDetail(
//       name: "Bob Williams",
//       email: "bob@example.com",
//       phone: "9876543210",
//       jobTitle: "Lead Developer",
//       company: "XYZ Ltd",
//     ),
//     product:
//         ProductDetail(name: "Web App", businessLine: "Software Development"),
//   ),
//   TaskDetail(
//     id: 3,
//     title: "Prepare Financial Report",
//     desc: "Compile Q3 financial report for board meeting",
//     dueDate: DateTime.now().add(Duration(days: 7)),
//     priority: TaskPriority.high,
//     status: TaskStatus.notStarted,
//     sender:
//         SenderDetail(assignor: "Michael Scott", cc: ["finance@example.com"]),
//     customer: CustomerDetail(
//       name: "Sarah Connor",
//       email: "sarah@example.com",
//       phone: "555666777",
//       jobTitle: "CFO",
//       company: "TechCorp",
//     ),
//     product:
//         ProductDetail(name: "Accounting Software", businessLine: "Finance"),
//   ),
//   TaskDetail(
//     id: 4,
//     title: "UI Design Update",
//     desc: "Improve user interface based on feedback",
//     dueDate: DateTime.now().add(Duration(days: 3)),
//     priority: TaskPriority.normal,
//     status: TaskStatus.inProgress,
//     sender: SenderDetail(assignor: "Emily Davis", cc: ["uiux@example.com"]),
//     customer: CustomerDetail(
//       name: "Tom Hardy",
//       email: "tom@example.com",
//       phone: "444555666",
//       jobTitle: "UI/UX Designer",
//       company: "Creative Inc",
//     ),
//     product:
//         ProductDetail(name: "Mobile App", businessLine: "Design & Development"),
//   ),
//   TaskDetail(
//     id: 5,
//     title: "Marketing Strategy Meeting",
//     desc: "Plan social media campaign for Q4",
//     dueDate: DateTime.now().add(Duration(days: 5)),
//     priority: TaskPriority.low,
//     status: TaskStatus.deffered,
//     sender:
//         SenderDetail(assignor: "Robert King", cc: ["marketing@example.com"]),
//     customer: CustomerDetail(
//       name: "Emma Watson",
//       email: "emma@example.com",
//       phone: "111222333",
//       jobTitle: "Marketing Director",
//       company: "AdWorld",
//     ),
//     product: ProductDetail(name: "Brand Campaign", businessLine: "Marketing"),
//   ),
//   TaskDetail(
//     id: 6,
//     title: "Bug Fixes",
//     desc: "Fix reported bugs from testing phase",
//     dueDate: DateTime.now().add(Duration(days: 1)),
//     priority: TaskPriority.high,
//     status: TaskStatus.inProgress,
//     sender: SenderDetail(assignor: "Chris Evans", cc: ["qa@example.com"]),
//     customer: CustomerDetail(
//       name: "Steve Rogers",
//       email: "steve@example.com",
//       phone: "777888999",
//       jobTitle: "QA Engineer",
//       company: "Shield Tech",
//     ),
//     product: ProductDetail(name: "Cybersecurity App", businessLine: "Security"),
//   ),
//   TaskDetail(
//     id: 7,
//     title: "Data Migration",
//     desc: "Migrate customer data to new database",
//     dueDate: DateTime.now().add(Duration(days: 6)),
//     priority: TaskPriority.normal,
//     status: TaskStatus.completed,
//     sender: SenderDetail(assignor: "Tony Stark", cc: ["it@example.com"]),
//     customer: CustomerDetail(
//       name: "Bruce Wayne",
//       email: "bruce@example.com",
//       phone: "333444555",
//       jobTitle: "CTO",
//       company: "Wayne Enterprises",
//     ),
//     product: ProductDetail(name: "Cloud Storage", businessLine: "IT Solutions"),
//   ),
//   TaskDetail(
//     id: 8,
//     title: "Product Demo",
//     desc: "Showcase new features to stakeholders",
//     dueDate: DateTime.now().add(Duration(days: 8)),
//     priority: TaskPriority.high,
//     status: TaskStatus.notStarted,
//     sender: SenderDetail(assignor: "Peter Parker", cc: ["sales@example.com"]),
//     customer: CustomerDetail(
//       name: "Clark Kent",
//       email: "clark@example.com",
//       phone: "999000111",
//       jobTitle: "VP Sales",
//       company: "Daily Planet",
//     ),
//     product: ProductDetail(name: "E-commerce Platform", businessLine: "Retail"),
//   ),
//   TaskDetail(
//     id: 9,
//     title: "Server Maintenance",
//     desc: "Perform scheduled maintenance on production servers",
//     dueDate: DateTime.now().add(Duration(days: 10)),
//     priority: TaskPriority.high,
//     status: TaskStatus.inProgress,
//     sender:
//         SenderDetail(assignor: "Natasha Romanoff", cc: ["devops@example.com"]),
//     customer: CustomerDetail(
//       name: "Nick Fury",
//       email: "nick@example.com",
//       phone: "555999000",
//       jobTitle: "Director",
//       company: "SHIELD",
//     ),
//     product:
//         ProductDetail(name: "Cloud Hosting", businessLine: "Infrastructure"),
//   ),
//   TaskDetail(
//     id: 10,
//     title: "HR Policy Update",
//     desc: "Revise company policies for remote work",
//     dueDate: DateTime.now().add(Duration(days: 12)),
//     priority: TaskPriority.low,
//     status: TaskStatus.completed,
//     sender: SenderDetail(assignor: "Bruce Banner", cc: ["hr@example.com"]),
//     customer: CustomerDetail(
//       name: "Diana Prince",
//       email: "diana@example.com",
//       phone: "123123123",
//       jobTitle: "HR Manager",
//       company: "Amazonia Ltd",
//     ),
//     product: ProductDetail(name: "Employee Handbook", businessLine: "HR"),
//   ),
// ];
