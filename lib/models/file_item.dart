part of 'models.dart';

class FileItem {
  final String name;
  final String path;
  final String type;
  final DateTime createdAt;
  DateTime? modifiedAt;
  final double size;

  FileItem({
    required this.name,
    required this.path,
    required this.type,
    required this.createdAt,
    DateTime? modifiedAt,
    this.size = 0,
  }) : modifiedAt = modifiedAt ?? createdAt;
}

List<FileItem> dummyFiles = [
  FileItem(
    name: 'Document.zip',
    path: 'assets/files/dummy.zip',
    type: 'zip',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    size: 200,
  ),
  FileItem(
    name: 'Image',
    path: 'assets/files/image.png',
    type: 'png',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    size: 150,
  ),
  FileItem(
    name: 'PDF',
    path: 'assets/files/document.pdf',
    type: 'pdf',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    size: 300,
  ),
  FileItem(
    name: 'Text',
    path: 'assets/files/text.txt',
    type: 'txt',
    createdAt: DateTime.now().subtract(const Duration(days: 8)),
    size: 50,
  ),
  FileItem(
    name: 'Archive',
    path: 'assets/files/archive.rar',
    type: 'rar',
    createdAt: DateTime.now().subtract(const Duration(days: 9)),
    size: 400,
  ),
  FileItem(
    name: 'Document',
    path: 'assets/files/dummy.zip',
    type: 'zip',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    size: 200,
  ),
  FileItem(
    name: 'Image',
    path: 'assets/files/image.png',
    type: 'png',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    size: 150,
  ),
  FileItem(
    name: 'PDF',
    path: 'assets/files/document.pdf',
    type: 'pdf',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    size: 300,
  ),
  FileItem(
    name: 'Text',
    path: 'assets/files/text.txt',
    type: 'txt',
    createdAt: DateTime.now().subtract(const Duration(days: 8)),
    size: 50,
  ),
  FileItem(
    name: 'Archive',
    path: 'assets/files/archive.rar',
    type: 'rar',
    createdAt: DateTime.now().subtract(const Duration(days: 9)),
    size: 400,
  ),
  FileItem(
    name: 'Document',
    path: 'assets/files/dummy.zip',
    type: 'zip',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    size: 200,
  ),
  FileItem(
    name: 'Image',
    path: 'assets/files/image.png',
    type: 'png',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    size: 150,
  ),
  FileItem(
    name: 'PDF',
    path: 'assets/files/document.pdf',
    type: 'pdf',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    size: 300,
  ),
  FileItem(
    name: 'Text',
    path: 'assets/files/text.txt',
    type: 'txt',
    createdAt: DateTime.now().subtract(const Duration(days: 8)),
    size: 50,
  ),
  FileItem(
    name: 'Archive',
    path: 'assets/files/archive.rar',
    type: 'rar',
    createdAt: DateTime.now().subtract(const Duration(days: 9)),
    size: 400,
  ),
  FileItem(
    name: 'Document',
    path: 'assets/files/dummy.zip',
    type: 'zip',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    size: 200,
  ),
  FileItem(
    name: 'Image',
    path: 'assets/files/image.png',
    type: 'png',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    size: 150,
  ),
  FileItem(
    name: 'PDF',
    path: 'assets/files/document.pdf',
    type: 'pdf',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    size: 300,
  ),
  FileItem(
    name: 'Text',
    path: 'assets/files/text.txt',
    type: 'txt',
    createdAt: DateTime.now().subtract(const Duration(days: 8)),
    size: 50,
  ),
  FileItem(
    name: 'Archive',
    path: 'assets/files/archive.rar',
    type: 'rar',
    createdAt: DateTime.now().subtract(const Duration(days: 9)),
    size: 400,
  ),
];
