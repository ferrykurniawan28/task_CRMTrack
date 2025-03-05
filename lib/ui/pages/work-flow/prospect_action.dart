import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/models.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ProspectAction extends StatefulWidget {
  final Staging staging;
  const ProspectAction({super.key, required this.staging});

  @override
  State<ProspectAction> createState() => _ProspectActionState();
}

class _ProspectActionState extends State<ProspectAction> {
  final _titleController = TextEditingController();
  final _addressController = TextEditingController();
  double? _selectedLat;
  double? _selectedLng;
  FilePickerResult? _document;
  List<PlatformFile>? _images;
  List<PlatformFile>? _videos;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  // Future<void> _loadSignature(Uint8List signatureBytes) async {
  //   _controller.clear();
  //   _controller.importSignature(signatureBytes);
  // }

  void submit() async {
    widget.staging.title = _titleController.text;
    widget.staging.address = _addressController.text;
    widget.staging.lat = _selectedLat;
    widget.staging.long = _selectedLng;
    widget.staging.documents = _document?.files.map((e) => e.name).toList();
    if (_images != null) {
      widget.staging.images = [];
      for (final image in _images!) {
        final imageFile = File(image.path!);
        final imageBytes = await imageFile.readAsBytes();
        final imageName = image.name;
        final imageDir = await getTemporaryDirectory();
        final imageFileDir = File('${imageDir.path}/$imageName');
        await imageFileDir.writeAsBytes(imageBytes);
        widget.staging.images!.add(imageFileDir.path);
      }
    }
    if (_videos != null) {
      widget.staging.videos = [];
      for (final video in _videos!) {
        final videoFile = File(video.path!);
        final videoBytes = await videoFile.readAsBytes();
        final videoName = video.name;
        final videoDir = await getTemporaryDirectory();
        final videoFileDir = File('${videoDir.path}/$videoName');
        await videoFileDir.writeAsBytes(videoBytes);
        widget.staging.videos!.add(videoFileDir.path);
      }
    }
    widget.staging.signature = await _controller.toPngBytes();
    widget.staging.isCompleted = true;
    _controller.disabled = true;

    setState(() {});
  }

  Future<String?> _getVideoThumbnail(String videoPath) async {
    final tempDir = await getTemporaryDirectory();
    return await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: '${tempDir.path}/thumb_${videoPath.split('/').last}.jpg',
      imageFormat: ImageFormat.JPEG,
      maxWidth: 200, // Adjust size as needed
      quality: 75,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.staging.isCompleted) {
      _controller.disabled = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _addressController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(workflowStageToString(widget.staging.stage)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(8),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
              foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.white,
            onSelected: (value) {
              if (value == 'edit') {
                // Handle edit action
              } else if (value == 'drop') {
                // Handle delete action
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'detail',
                child: Row(
                  children: [
                    const Icon(Icons.visibility_outlined, color: Colors.black),
                    spacerWidth(10),
                    const Text('Detail'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'drop',
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.black,
                    ),
                    spacerWidth(10),
                    const Text('Drop'),
                  ],
                ),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          spacerWidth(10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Step',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE6E6E6),
                        ),
                      ),
                      spacerHeight(6),
                      Text(
                        workflowStageToString(widget.staging.stage),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: medium,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  spacerHeight(16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Last Update',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFE6E6E6),
                              ),
                            ),
                            spacerHeight(6),
                            Row(
                              children: [
                                Image.asset('assets/icon/calendar2-day.png',
                                    color: Colors.white),
                                spacerWidth(10),
                                Text(
                                  DateFormat('hh.mm  dd MMM yyyy')
                                      .format(widget.staging.lastUpdated),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Created By',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFE6E6E6),
                              ),
                            ),
                            spacerHeight(6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                spacerWidth(4),
                                Text(
                                  widget.staging.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            spacerHeight(24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tittle',
                        style: TextStyle(fontSize: 16),
                      ),
                      spacerHeight(12),
                      (widget.staging.isCompleted == true)
                          ? Text(
                              widget.staging.title ?? "No Title",
                              style: const TextStyle(
                                  fontSize: 14, color: Color(0xFF899197)),
                            )
                          : textForm(
                              _titleController,
                              'Title',
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Title is required';
                                }
                                return null;
                              },
                            ),
                    ],
                  ),
                  spacerHeight(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(fontSize: 16),
                      ),
                      spacerHeight(12),
                      SizedBox(
                        width: double.infinity,
                        child: (widget.staging.isCompleted == true)
                            ? Text(
                                widget.staging.address ?? "No Address",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF899197),
                                  overflow: TextOverflow.visible,
                                ),
                                softWrap: true,
                              )
                            : textForm(_addressController, 'Address', (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Address is required';
                                }
                                return null;
                              }),
                      ),
                    ],
                  ),
                  spacerHeight(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Maps',
                        style: TextStyle(fontSize: 16),
                      ),
                      spacerHeight(12),
                      Stack(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 147,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: Colors.grey,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xFFF14548),
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: ((widget.staging.lat != null &&
                                          widget.staging.long != null) ||
                                      (_selectedLat != null &&
                                          _selectedLng != null))
                                  ? Stack(
                                      children: [
                                        FlutterMap(
                                          options: MapOptions(
                                            initialCenter:
                                                (widget.staging.lat != null &&
                                                        widget.staging.long !=
                                                            null)
                                                    ? LatLng(
                                                        widget.staging.lat!,
                                                        widget.staging.long!)
                                                    : LatLng(_selectedLat!,
                                                        _selectedLng!),
                                            initialZoom: 9.2,
                                          ),
                                          children: [
                                            TileLayer(
                                              urlTemplate:
                                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                              userAgentPackageName:
                                                  'com.example.app',
                                            ),
                                            MarkerLayer(markers: [
                                              if (widget.staging.lat != null &&
                                                  widget.staging.long != null)
                                                Marker(
                                                  width: 80.0,
                                                  height: 80.0,
                                                  point: LatLng(
                                                      widget.staging.lat!,
                                                      widget.staging.long!),
                                                  child: Icon(
                                                    Icons.location_on,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              if (_selectedLat != null &&
                                                  _selectedLng != null)
                                                Marker(
                                                  width: 80.0,
                                                  height: 80.0,
                                                  point: LatLng(_selectedLat!,
                                                      _selectedLng!),
                                                  child: Icon(
                                                    Icons.location_on,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                            ]),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selectedLat = null;
                                                  _selectedLng = null;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: primaryColor,
                                              )),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: IconButton(
                                        onPressed: () => Modular.to.pushNamed(
                                          '/workflow/maps',
                                          arguments: {
                                            'isSelecting': true,
                                            'onTap': (tapPosition, point) {
                                              setState(() {
                                                _selectedLat = point.latitude;
                                                _selectedLng = point.longitude;
                                              });
                                            },
                                          },
                                        ),
                                        icon: const Icon(
                                            Icons.add_location_alt_outlined),
                                      ),
                                    ),
                            ),
                          ),
                          if (widget.staging.isCompleted)
                            Container(
                              clipBehavior: Clip.antiAlias,
                              height: 147,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFF14548),
                                  width: 1,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  spacerHeight(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Document File',
                        style: TextStyle(fontSize: 16),
                      ),
                      spacerHeight(12),
                      if (widget.staging.documents == null && _document == null)
                        GestureDetector(
                          onTap: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'doc', 'docx'],
                            );

                            if (result != null) {
                              setState(() {
                                _document = result;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.file_copy_outlined,
                                  color: primaryColor,
                                ),
                                spacerWidth(10),
                                Text(
                                  'Upload File',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.upload_outlined,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/file-pdf.png',
                              width: 24,
                              height: 24,
                            ),
                            spacerWidth(10),
                            TextButton(
                              onPressed: () {
                                OpenFile.open(
                                    _document?.files.first.path ?? '');
                              },
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(0),
                                ),
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                  const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              child: Text(
                                _document?.files.first.name ??
                                    widget.staging.documents?.join(', ') ??
                                    'No Document',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _document = null;
                                });
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  spacerHeight(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Photos',
                        style: TextStyle(fontSize: 16),
                      ),
                      spacerHeight(12),
                      if ((widget.staging.images == null ||
                              widget.staging.images!.isEmpty) &&
                          (_images == null || _images!.isEmpty))
                        SizedBox(
                          height: 68,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    final result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                      allowMultiple: true,
                                    );

                                    if (result != null) {
                                      setState(() {
                                        _images = result.files;
                                      });
                                    }
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(7),
                                    color: primaryColor,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera_alt_outlined,
                                            color: primaryColor,
                                          ),
                                          Text(
                                            'Add Photo',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              spacerWidth(16),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    final result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.video,
                                      allowMultiple: true,
                                    );

                                    if (result != null) {
                                      setState(() {
                                        _videos = result.files;
                                      });
                                    }
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(7),
                                    color: primaryColor,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.videocam_outlined,
                                            color: primaryColor,
                                          ),
                                          Text(
                                            'Add Video',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        SizedBox(
                          height: 100,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount:
                                (_images?.length ?? 0) + (_videos?.length ?? 0),
                            itemBuilder: (context, index) {
                              if (index < (_images?.length ?? 0)) {
                                final image = _images![index];
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.file(
                                          File(image.path!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _images!.removeAt(index);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                final videoIndex =
                                    index - (_images?.length ?? 0);
                                final video = _videos![videoIndex];
                                return FutureBuilder<String?>(
                                  future: _getVideoThumbnail(video.path!),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: Image.file(
                                              File(snapshot
                                                  .data!), // Thumbnail image
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          ),
                                          const Center(
                                            child: Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const Center(
                                          child:
                                              Text('Failed to load thumbnail'));
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                  spacerHeight(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Signature Head Departement',
                        style: TextStyle(fontSize: 16),
                      ),
                      spacerHeight(12),
                      Container(
                        height: 183,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFC6C7C8),
                            width: 3,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Container(
                          // height: 183,
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFC6C7C8),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(7),
                            ),
                          ),
                          child: Stack(
                            children: [
                              if (widget.staging.signature != null)
                                Image.memory(
                                  widget.staging.signature!,
                                  fit: BoxFit.contain,
                                ),
                              Signature(
                                controller: _controller,
                                width: double.infinity,
                                height: double.infinity,
                                backgroundColor: Colors.white,
                              ),
                              if (!widget.staging.isCompleted)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _controller.clear();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                        const Color(0xFFE6E6E6),
                                      ),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      padding: WidgetStateProperty.all<
                                          EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 8,
                                        ),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.delete_outline_rounded,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  spacerHeight(20),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: (widget.staging.isCompleted)
          ? null
          : Container(
              height: 70,
              padding: const EdgeInsets.only(
                  left: 18, right: 18, top: 6, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.9,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: submit,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                  textStyle: WidgetStateProperty.all<TextStyle>(
                    TextStyle(
                      fontSize: 16,
                      fontWeight: medium,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Text('Submit',
                    style: TextStyle(
                        fontSize: 16, fontWeight: medium, color: Colors.white)),
              ),
            ),
    );
  }

  TextFormField textForm(TextEditingController controller, String hint,
      String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      // initialValue: widget.staging.title,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFF899197),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFC6C7C8),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE6E6E6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
