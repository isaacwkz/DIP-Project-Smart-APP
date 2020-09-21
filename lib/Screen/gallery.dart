import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:dip_taskplanner/Screen/camera.dart';


// Entry point into the gallery
class GalleryPageEntry extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<GalleryPageEntry> {

  String _path = null;

  /*void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _path = file.path;
    });

  }*/

  void _showOptions(BuildContext context) {

    showModalBottomSheet(
        context: context,
        builder: (context) {
          /*return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text("Take a picture from camera")
                ),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary();
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library")
                )
              ])
              print("got to cointainer");
          );*/
          print("got to cointainer");
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*body: SafeArea(
          child: Column(children: <Widget>[
            //_path == null ? Image.asset("images/place-holder.png") :
            //Image.file(File(_path))
            //,
            FlatButton(
              child: Text("Take Picture", style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () {
                _showOptions(context);
              },
            )
          ]),*/
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return BackButton();
          },
        ),
        title: const Text('Gallery'),
      ),
      body: const Center(
        child: Text(
          'This is the next page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pop(context);
          Navigator.push(context,MaterialPageRoute(builder: (context) => openCamera()),);
        },
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.blue,
      )
    );

  }

}