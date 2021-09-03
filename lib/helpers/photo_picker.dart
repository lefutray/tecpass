import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:tec_pass/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<File?> _takePhoto(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  final appDir = await getApplicationDocumentsDirectory();
  final appPath = appDir.path;
  final pickedFile = await _picker.pickImage(
    source: source,
  );
  if (pickedFile == null) return null;

  File tmpFile = File(pickedFile.path);
  String fileName = path.basename(pickedFile.path);
  tmpFile = await tmpFile.copy('$appPath/$fileName');
  return tmpFile;
}

_sourceOptions(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      TextButton.icon(
        icon: Icon(Icons.camera, color: Colors.black),
        onPressed: () async {
          final photo = await _takePhoto(ImageSource.camera);
          if (photo != null) {
            final stringPhoto = base64Encode(photo.readAsBytesSync());
            context.read<UserBloc>().add(PhotoChanged(stringPhoto));
          }
        },
        label: Text('Cámara', style: TextStyle(color: Colors.black)),
      ),
      TextButton.icon(
        icon: Icon(Icons.image, color: Colors.black),
        onPressed: () async {
          final photo = await _takePhoto(ImageSource.gallery);
          if (photo != null) {
            final stringPhoto = base64Encode(photo.readAsBytesSync());
            context.read<UserBloc>().add(PhotoChanged(stringPhoto));
          }
        },
        label: Text('Galería', style: TextStyle(color: Colors.black)),
      ),
    ],
  );
}

pickUserPhoto(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: ((builder) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Elegir foto',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            _sourceOptions(context),
          ],
        ),
      );
    }),
    backgroundColor: Colors.transparent,
  );
}
