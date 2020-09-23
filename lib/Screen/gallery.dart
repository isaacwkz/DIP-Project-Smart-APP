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
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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

  /********  Start of Sample Gallery Code   **************
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: AssetImage(widget.galleryItems[index].image),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes: HeroAttributes(tag: galleryItems[index].id),
            );
          },
          itemCount: galleryItems.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes,
              ),
            ),
          ),
          backgroundDecoration: widget.backgroundDecoration,
          pageController: widget.pageController,
          onPageChanged: onPageChanged,
        )
    );
  }

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
  ********  End of Sample Gallery Code   ***************/

@override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(children: <Widget>[
            _path == null ? Image.asset("images/TestTest.png"): Image.file(File(_path)),
            /* Display a FlatButton underneath the placeholder image
            FlatButton(
              child: Text("Take Picture", style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () {
                //_showOptions(context);
              },
            )*/
          ]),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return BackButton();
            },
          ),
          title: const Text('Tutorial Notes'),
        ),

        /* Placeholder text
        body: const Center(
          child: Text(
            'TODO: Make the gallery',
            style: TextStyle(fontSize: 24),
          ),
        ),*/

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder: (context) => CameraPageEntry()),);
          },
          label: Text('Take a photo'),
          icon: Icon(Icons.add_a_photo),
          backgroundColor: Colors.white,
        )
      );

  }

}