class TaskDetail {
  int? id;
  String title;
  String desc;
  DateTime dueDate;
  TaskPriority priority;
  TaskStatus status;
  SenderDetail sender;
  CustomerDetail customer;
  ProductDetail product;

  TaskDetail({
    this.id,
    required this.title,
    required this.desc,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.sender,
    required this.customer,
    required this.product,
  });

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    return TaskDetail(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
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
      'dueDate': dueDate.toIso8601String(),
      'priority': priority.index,
      'status': status.index,
      'sender': sender.toJson(),
      'customer': customer.toJson(),
      'product': product.toJson(),
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
  List<String> cc;

  SenderDetail({
    required this.assignor,
    required this.cc,
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

List<TaskDetail> dummyTask = [
  TaskDetail(
    id: 1,
    title: 'Task 1',
    desc: 'Description 1',
    dueDate: DateTime.now(),
    priority: TaskPriority.high,
    status: TaskStatus.notStarted,
    sender: SenderDetail(
      assignor: 'Assignor 1',
      cc: ['CC 1', 'CC 2'],
    ),
    customer: CustomerDetail(
      name: 'Customer 1',
      email: 'customer@email.com',
      phone: '08123456789',
      jobTitle: 'Job Title 1',
      company: 'Company 1',
    ),
    product: ProductDetail(
      name: 'Product 1',
      businessLine: 'Business Line 1',
    ),
  ),
  TaskDetail(
    id: 2,
    title: 'Task 2',
    desc: 'Description 2',
    dueDate: DateTime.now(),
    priority: TaskPriority.normal,
    status: TaskStatus.inProgress,
    sender: SenderDetail(
      assignor: 'Assignor 2',
      cc: ['CC 3', 'CC 4'],
    ),
    customer: CustomerDetail(
      name: 'Customer 2',
      email: 'customer2@gmail.com',
      phone: '08123456789',
      jobTitle: 'Job Title 2',
      company: 'Company 2',
    ),
    product: ProductDetail(
      name: 'Product 2',
      businessLine: 'Business Line 2',
    ),
  ),
  TaskDetail(
    id: 3,
    title: 'Task 2',
    desc: 'Description 2',
    dueDate: DateTime.now(),
    priority: TaskPriority.low,
    status: TaskStatus.inProgress,
    sender: SenderDetail(
      assignor: 'Assignor 2',
      cc: ['CC 3', 'CC 4'],
    ),
    customer: CustomerDetail(
      name: 'Customer 2',
      email: 'customer2@gmail.com',
      phone: '08123456789',
      jobTitle: 'Job Title 2',
      company: 'Company 2',
    ),
    product: ProductDetail(
      name: 'Product 2',
      businessLine: 'Business Line 2',
    ),
  ),
];
