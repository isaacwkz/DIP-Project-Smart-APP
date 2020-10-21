import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:media_gallery/media_gallery.dart';
import 'package:dip_taskplanner/picker/picker.dart';
import 'package:dip_taskplanner/picker/selection.dart';
import 'package:dip_taskplanner/picker/media.dart';
import 'package:dip_taskplanner/picker/thumbnail.dart';


// Entry point into the gallery
class GalleryPageEntry extends StatefulWidget {
  @override
  _GalleryExampleState createState() => _GalleryExampleState();
}

class _GalleryExampleState extends State<GalleryPageEntry> {
  MediaPickerSelection selection;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Media Gallery"),
          ),
          body: SelectionGrid(
            selection: selection,
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              onPressed: () async {
                final result = await MediaPicker.show(context);
                if (result != null) {
                  setState(() => selection = result);
                }
              },
              child: Icon(Icons.image),
            ),
          ),
      );
  }
}

class SelectionGrid extends StatelessWidget {
  final MediaPickerSelection selection;

  const SelectionGrid({
    @required this.selection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: selection == null || selection.selectedMedias.isEmpty
          ? Text("No selection")
          : Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: <Widget>[
          ...selection.selectedMedias.map<Widget>(
                (x) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MediaViewerPage(media: x),
                  ),
                );
              },
              child: SizedBox(
                width: 128,
                height: 128,
                child: MediaThumbnailImage(media: x),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
