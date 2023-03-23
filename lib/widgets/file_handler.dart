import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tabler_icons/tabler_icons.dart';

class FileHandler extends StatefulWidget {
  const FileHandler({Key? key}) : super(key: key);

  @override
  State<FileHandler> createState() => _FileHandlerState();
}

class _FileHandlerState extends State<FileHandler> {
  PlatformFile? file;

  Future selectFile() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (res == null) return;
    final file = res.files.single;

    print(file.name);
    print('${file.size}');
    print('${file.extension}');

    // final path = res.files.single.path!;

    setState(() {
      file;
    });
  }

  @override
  void initState() {
    super.initState();
    file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Add multiple products',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.teal[900]),
          ),
          const Text(
              'You can add multiple products by uploading a spreadsheet.'),
          file == null
              ? Column(
                  children: [
                    buildFileSelector(),
                    const SizedBox(height: 20),
                    const Text('No file picked')
                  ],
                )
              : Column(
                  children: [
                    buildAltFileSelector(),
                    const SizedBox(height: 20),
                    // buildFileInfo(),
                  ],
                ),
          ElevatedButton.icon(
              onPressed: () => debugPrint('uploading file'),
              icon: const Icon(
                TablerIcons.upload,
                size: 14,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Uplaod file'),
              )),
        ]),
      ),
    );
  }

  Widget buildFileSelector() {
    return GestureDetector(
        onTap: selectFile,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: DottedBorder(
            color: Colors.teal.shade900,
            strokeWidth: 8,
            dashPattern: const [16, 6],
            borderType: BorderType.RRect,
            radius: const Radius.circular(14),
            child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(14)),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      TablerIcons.file_text,
                      size: 48,
                    ),
                    SizedBox(height: 16),
                    Text('Click to select a file'),
                  ],
                ))),
          ),
        ));
  }

  Widget buildAltFileSelector() {
    return GestureDetector(
        onTap: selectFile,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: DottedBorder(
            color: Colors.amber,
            strokeWidth: 8,
            dashPattern: const [16, 6],
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      TablerIcons.file_text,
                      size: 48,
                    ),
                    SizedBox(height: 16),
                    Text('Click to select another file'),
                  ],
                ))),
          ),
        ));
  }

  Widget buildFileInfo(file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    final ext = file.extension ?? 'none';

    return Container(
      padding: const EdgeInsets.all(16),
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber, width: 8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'File name: ${file.name}',
          overflow: TextOverflow.ellipsis,
        ),
        Text('File extension: $ext'),
        Text('File size: ${file.size} $fileSize'),
      ]),
    );
  }
}
