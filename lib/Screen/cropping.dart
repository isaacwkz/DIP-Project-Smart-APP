import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:dip_taskplanner/Screen/gallery.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:image_picker/image_picker.dart';

class CropScreenArguments {
  final String filePath;
  final String fileName;

  CropScreenArguments(this.filePath, this.fileName);
}

// Entry point into the gallery
class CroppingPageEntry extends StatefulWidget {
  @override
  _CroppingState createState() => _CroppingState();
}

class _CroppingState extends State<CroppingPageEntry> {
  File imageFile;

  cropping(context) async {

    final CropScreenArguments args = ModalRoute.of(context).settings.arguments;
    final imageFilePath = args.filePath;

    print("Cropping photo: $imageFilePath");

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
    if (croppedFile != null) {
      imageFile = croppedFile;
      await imageFile.copy('$imageFilePath');
    }
  }


  @override
  void initState() {
    super.initState();
    _cropThis(context);

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future _cropThis(context) async {
    await Future.delayed(Duration(milliseconds: 100));
      cropping(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
