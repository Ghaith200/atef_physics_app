import 'dart:io';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CustomFilePicker extends StatefulWidget {
  const CustomFilePicker({super.key});

  @override
  _CustomFilePickerState createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  File? selectedFile;
  String? _fileName;
  int? _fileSize;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        final file = File(filePath);

        setState(() {
          selectedFile = file;
          _fileName = result.files.single.name; // File name
          _fileSize = result.files.single.size; // File size in bytes
        });
      } else {
        // User canceled the picker
        AppSnackBar.showSnackBar(context, "File picking was canceled.");
      }
    } catch (e) {
      // Handle errors
      AppSnackBar.showSnackBar(context, "Failed to pick file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _pickFile,
            child: const Text("Pick a File"),
          ),
          const SizedBox(height: 20),
          if (_fileName != null) ...[
            const Text(
              "File Information:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Name: $_fileName"),
            Text("Size: ${(_fileSize! / 1024).toStringAsFixed(2)} KB"),
          ],
        ],
      ),
    );
  }
}
