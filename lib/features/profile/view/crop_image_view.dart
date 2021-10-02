import 'dart:async';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

class CropImageView extends StatefulWidget {
  const CropImageView({Key? key, required this.image}) : super(key: key);

  final Uint8List image;

  @override
  _CropImageViewState createState() => _CropImageViewState();
}

class _CropImageViewState extends State<CropImageView> {
  StreamController<CropStatus> status = StreamController.broadcast();

  @override
  void dispose() {
    status.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = CropController();
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Crop(
                image: widget.image,
                controller: controller,
                aspectRatio: 1,
                initialSize: 0.8,
                onCropped: (image) => Navigator.pop(context, image),
                onStatusChanged: (status) => this.status.add(status),
                onMoved: (offset) {},
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancelar', style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      MaterialButton(
                        onPressed: () => controller.crop(),
                        child: Text('Guardar', style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder(
            stream: status.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != CropStatus.ready) {
                  return AbsorbPointer(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: CircularProgressIndicator()),
                          SizedBox(height: 20),
                          Text('Guardando...'),
                        ],
                      ),
                    ),
                    absorbing: true,
                  );
                }
                return Container();
              }
              return AbsorbPointer(absorbing: true);
            },
          ),
        ],
      ),
    );
  }
}
