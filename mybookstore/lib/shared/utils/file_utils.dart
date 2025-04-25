import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

extension FileExtension on File {
  String get name => path.split('?').first.split('/').last;

  Future<String> get base64 async {
    final bytes = await readAsBytes();
    return base64Encode(bytes);
  }

  String get base64Sync => base64Encode(readAsBytesSync());
}

Future<File?> getImage(BuildContext context) async {
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (context) {
      return Material(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 16.0,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                  child: Row(
                    spacing: 8.0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt),
                      const Text('Camera'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                  child: Row(
                    spacing: 8.0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [const Icon(Icons.image), const Text('Galeria')],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  if (source != null) {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      return File(image.path);
    }
  }
  return null;
}
