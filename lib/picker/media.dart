import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_gallery/media_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:dip_taskplanner/Screen/Annotation.dart';
//import 'package:path/path.dart';

class MediaViewerPage extends StatelessWidget {
  final Media media;

  const MediaViewerPage({
    @required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(media.id),
      ),
      body: media.mediaType == MediaType.image
          ? MediaImagePlayer(
              media: media,
            )
          : MediaImagePlayer(
              media: media,
            ),
    );
  }
}

class MediaImagePlayer extends StatefulWidget {
  final Media media;

  const MediaImagePlayer({
    @required this.media,
  });

  @override
  _MediaImagePlayerState createState() => _MediaImagePlayerState();
}

//This class contains the widget to open the fullsized media
class _MediaImagePlayerState extends State<MediaImagePlayer> {
  File file;
  Map<String, IfdTag> exif;
  File _image;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAsync();
    });
    super.initState();
  }

  Future<void> initAsync() async {
    try {
      this.file = await widget.media.getFile();
      this.exif = await readExifFromBytes(await this.file.readAsBytes());
      this.setState(() {});
    } catch (e) {
      print("Failed : $e");
    }
  }

  //This widget show the selected media in full size
  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: MemoryImage(kTransparentImage),
            image: MediaImageProvider(
              media: widget.media,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: () {
                print("sending ${this.file.path} into photo editor");
                getimageditor(File("${this.file.path}"));
              },
              label: Text('Edit Photo'),
              icon: Icon(Icons.edit),
              backgroundColor: Colors.white,
            ),
            Expanded(
              child: Container(
                //padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Course Notes",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> getimageditor(File _imageToEdit) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ImageEditorPro(
            editdis: File("${_imageToEdit.path}"),
            appBarColor: Colors.blue,
            bottomBarColor: Colors.blue,
          );
        //then set _image to the edited image returned from above function call
        })).then((geteditimage) {
          if (geteditimage != null) {
            setState(() {
              _image = geteditimage;
            }   );
          }
        }).catchError((er) {
          print(er);
        });
  }
}
