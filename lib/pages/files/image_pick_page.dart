import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImagePickPage extends StatefulWidget {
  const ImagePickPage({super.key});

  @override
  State<ImagePickPage> createState() => _ImagePickPageState();
}

class _ImagePickPageState extends State<ImagePickPage> {
  FilePickerResult? result;
  List pickedFiles = [];
  List pickedPaths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select images')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            pickedFiles.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: pickedFiles.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Image.file(File(pickedPaths[index])),
                                );
                              },
                            );
                          },
                          child: ListTile(title: Text(pickedFiles[index])),
                        );
                      },
                    ),
                  )
                : Text('No items picked'),

            ElevatedButton(onPressed: selectFile, child: Text('Select file')),
          ],
        ),
      ),
    );
  }

  Future<void> selectFile() async {
    result = await FilePicker.platform.pickFiles();

    pickedFiles += result!.files.map((file) => file.name).toList();
    pickedPaths += result!.files.map((file) => file.path).toList();

    log('Picked file: $pickedFiles');

    setState(() {});
  }
}
