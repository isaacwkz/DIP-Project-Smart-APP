import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      Fluttertoast.showToast(
          msg: "Saving cropped image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black45,
          fontSize: 16.0
      );
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
