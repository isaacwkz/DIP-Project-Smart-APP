import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:dip_taskplanner/Screen/gallery.dart';
import 'package:image_cropper/image_cropper.dart';

// Entry point into the gallery
class CroppingPageEntry extends StatefulWidget {
  @override
  _CroppingState createState() => _CroppingState();
}

class _CroppingState extends State<CroppingPageEntry> {

  cropping(context) async {

    final temppath = await getExternalStorageDirectories();
    final imageFilePath = "temppath.path";

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFilePath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

};