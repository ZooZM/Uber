import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber/core/utils/app_fun.dart';

Future<File?> showCustomChooseImageSource(BuildContext context) {
  return showModalBottomSheet<File>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              try {
                final image = await AppFun.pickImage(
                  imageSource: ImageSource.camera,
                );
                Navigator.pop(context, image);
              } catch (e) {}
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () async {
              try {
                final image = await AppFun.pickImage(
                  imageSource: ImageSource.gallery,
                );
                Navigator.pop(context, image);
              } catch (e) {}
            },
          ),
        ],
      ),
    ),
  );
}
