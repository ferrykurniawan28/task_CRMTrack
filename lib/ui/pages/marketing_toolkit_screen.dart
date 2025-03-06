import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarketingToolkitScreen extends StatefulWidget {
  const MarketingToolkitScreen({super.key});

  @override
  State<MarketingToolkitScreen> createState() => _MarketingToolkitScreenState();
}

class _MarketingToolkitScreenState extends State<MarketingToolkitScreen> {
  bool _showGrid = true;
  final List<FileItem> _files = dummyFiles;
  List<FileItem>? _recentFiles;
  List<FileItem>? _previousFiles;

  Image getFileIcon(String type) {
    switch (type) {
      case 'jpg':
        return Image.asset('assets/icon/file-image.png');
      case 'png':
        return Image.asset('assets/icon/file-image.png');
      case 'pdf':
        return Image.asset('assets/icon/file-pdf.png');
      case 'zip':
        return Image.asset('assets/icon/file-zip.png');
      case 'rar':
        return Image.asset('assets/icon/file-zip.png');
      default:
        return Image.asset('assets/icon/file-text.png');
    }
  }

  void fileDetail(
    BuildContext context,
    FileItem file,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      scrollControlDisabledMaxHeightRatio: 0.95,
      builder: (context) {
        return Container(
          padding:
              const EdgeInsets.only(top: 12, bottom: 24, left: 20, right: 20),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 33,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            'Info',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: -15,
                      top: -12,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: medium),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              spacerHeight(14),
              Image.asset('assets/images/Poster.png'),
              spacerHeight(14),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    spacerHeight(4),
                    Text(
                      '${file.size} KB',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF899197),
                      ),
                    ),
                  ],
                ),
              ),
              spacerHeight(19),
              const Divider(
                color: Color(0xFFC6C7C8),
                thickness: 1,
              ),
              spacerHeight(19),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Type',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF7A7C7F),
                            ),
                          ),
                          Text(
                            file.type,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF7A7C7F),
                            ),
                          ),
                          Text(
                            '${file.size} KB',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              spacerHeight(19),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Created',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7A7C7F),
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(file.createdAt),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              spacerHeight(19),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Modified',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7A7C7F),
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy')
                          .format(file.modifiedAt ?? file.createdAt),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _recentFiles = _files.where((file) {
      final now = DateTime.now();
      return file.modifiedAt!.isAfter(now.subtract(const Duration(days: 3)));
    }).toList();

    _previousFiles = _files.where((file) {
      final now = DateTime.now();
      return file.modifiedAt!.isBefore(now.subtract(const Duration(days: 3)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketing Toolkit'),
        backgroundColor: primaryColor,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              spacerHeight(14),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  hintText: 'Search File',
                  hintStyle: const TextStyle(
                    color: Color(0xFF899197),
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF899197),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFFE6E6E6),
                    ),
                  ),
                ),
              ),
              spacerHeight(12),
              Row(
                children: [
                  Text('Files',
                      style: TextStyle(fontSize: 14, fontWeight: medium)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => setState(() => _showGrid = !_showGrid),
                    child: Image.asset(
                      _showGrid
                          ? 'assets/icon/view-list.png'
                          : 'assets/icon/ui-checks-grid.png',
                    ),
                    // child: Image.asset('assets/icon/view-list.png'),
                  ),
                ],
              ),
              spacerHeight(12),
              SizedBox(
                width: double.infinity,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Recent Files',
                        style: TextStyle(fontSize: 14, fontWeight: medium)),
                    spacerHeight(12),
                    switch (_showGrid) {
                      true => GridView.builder(
                          itemCount: _recentFiles!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (context, index) {
                            final file = _recentFiles![index];
                            return GestureDetector(
                              onTap: () {
                                fileDetail(context, file);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: const Color(0xFFF9FAFB),
                                    ),
                                    child: getFileIcon(file.type),
                                  ),
                                  spacerHeight(4),
                                  Text(
                                    file.name,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: medium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy')
                                        .format(file.modifiedAt!),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF899197),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      false => ListView.builder(
                          itemCount: _recentFiles!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final file = _recentFiles![index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    fileDetail(context, file);
                                  },
                                  child: SizedBox(
                                    height: 39,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 42,
                                          height: 39,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: const Color(0xFFF9FAFB),
                                          ),
                                          child: getFileIcon(file.type),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              file.name,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: medium,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(file.modifiedAt!),
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF899197),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.more_horiz),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                spacerHeight(12),
                              ],
                            );
                          },
                        ),
                    }
                  ],
                ),
              ),
              spacerHeight(12),
              SizedBox(
                width: double.infinity,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Previous Files',
                        style: TextStyle(fontSize: 14, fontWeight: medium)),
                    spacerHeight(12),
                    switch (_showGrid) {
                      true => GridView.builder(
                          itemCount: _previousFiles!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.65,
                          ),
                          itemBuilder: (context, index) {
                            final file = _previousFiles![index];
                            return GestureDetector(
                              onTap: () {
                                fileDetail(context, file);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: const Color(0xFFF9FAFB),
                                    ),
                                    child: getFileIcon(file.type),
                                  ),
                                  spacerHeight(4),
                                  Text(
                                    file.name,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: medium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy')
                                        .format(file.modifiedAt!),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF899197),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      false => ListView.builder(
                          itemCount: _previousFiles!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final file = _previousFiles![index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    fileDetail(context, file);
                                  },
                                  child: SizedBox(
                                    height: 39,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 42,
                                          height: 39,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: const Color(0xFFF9FAFB),
                                          ),
                                          child: getFileIcon(file.type),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              file.name,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: medium,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(file.modifiedAt!),
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Color(0xFF899197),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                spacerHeight(12),
                              ],
                            );
                          },
                        )
                    }
                  ],
                ),
              ),
              spacerHeight(12),
            ],
          ),
        ),
      ),
    );
  }
}
