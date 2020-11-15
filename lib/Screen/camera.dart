import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as p;
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:dip_taskplanner/Screen/cropping.dart';
import 'package:dip_taskplanner/picker/picker.dart';
import 'package:dip_taskplanner/picker/media.dart';
import 'package:dip_taskplanner/database/database.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Entry point into Camera
class CameraPageEntry extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraPageEntry> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  String imgPath;



  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController.dispose();
    }

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController.value.hasError) {
      print('Camera Error ${cameraController.value.errorDescription}');
    }

    try {
      await cameraController.initialize();
    } catch (e) {
      showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  /// Display camera preview
  Widget cameraPreview() {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    }

    return AspectRatio(
      aspectRatio: cameraController.value.aspectRatio,
      child: CameraPreview(cameraController),
    );
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            FloatingActionButton(
              heroTag: "Capture",
              child: Icon(
                Icons.camera,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                print("shutter!");
                onCapture(context);
              },
            ),

          ],
        ),
      ),
    );
  }
  Widget galleryWidget(context) {
    return Expanded(
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "Gallery",
                child: Icon(
                  Icons.collections,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                onPressed: () async {
                  //Navigator.pop(context);

                  final result = await MediaPicker.show(context);
                  if (result != null) {
                    print("pushing image viewer route");
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            MediaViewerPage(media: result.
                            selectedMedias[0])));
                  }
                },
                /*onPressed: () async {
                  final result = await MediaPicker.show(context);
                  if (result != null) {
                    //setState(() => selection = result);
                  }
                },*/
              )
              ],
          ),
        ),
    );
  }
  Widget cameraToggle() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
            onPressed: () {
              onSwitchCamera();
            },
            icon: Icon(
              getCameraLensIcons(lensDirection),
              color: Colors.white,
              size: 24,
            ),
            shape: RoundedRectangleBorder(),
            label: Text(
              '${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1).toUpperCase()}',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )),
      ),
    );
  }

  onCapture(context) async {
    var permissionStatus = await Permission.storage.status;
    if(!permissionStatus.isGranted){
      await Permission.storage.request();
    }

    //Get the absolute path to the emulated storage space
    //should be something along the lines of /storage/emulated/0/
    //actual path depends on manufacturer implementation - hence the use of path_provider
    print("getting directory:");
    final storageInfo = await PathProviderEx.getStorageInfo();
    //store files to /sdcard/dip_taskplanner/
    final Directory photoDir = Directory(p.join('${storageInfo[0].rootDir}', 'dip_taskplanner'));
    print(photoDir.path);
    //DateTime is used to set filename
    //NOTE: colons ":" are not allowed in filenames
    final currentDateAndTime = DateTime.now();
    String fileName = DateFormat('yyyyMMdd–kkmmss').format(currentDateAndTime);

    String moduleCode;
    print("Today is a ${DateFormat('EEE').format(currentDateAndTime).toUpperCase()}");

    //Attempt to get course details from DB
    try {
      print("get courseID from database");
      final courseID = await DatabaseHelper.instance.retrieveCourses();
      //Logic to get current CourseID
      //Iterate through List<Courses> courseID
      for(int i = 0; courseID[i] != null ; i++) {
        //Attempt to PARTIAL match day of week to current day
        if (courseID[i].weekDay.toUpperCase().contains(
            '${DateFormat('EEE').format(currentDateAndTime).toUpperCase()}')) {
          //There is a match
          //Set moduleCode
          moduleCode = courseID[i].courseId.toUpperCase();
          //break out of for loop
          break;
        } else {
          moduleCode = "Unsorted";
        }
      }
    } catch(e){
      //This catches the case when either
      //1) DB is unable to retrieve course details
      //   This happens when user did not enter course details
      //2) The above code is unable to get a match for current day of the week
      print("CAMERA: CourseID error: $e");
      //Hence, we set moduleCode as "Unsorted"
      moduleCode = "Unsorted";
    }

    print(moduleCode);
    //check and create the folder if it does not exist
    final Directory tempDirectory = Directory(p.join('${photoDir.path}', '$moduleCode'));
    print('Check whether directory exists: $tempDirectory');
    if(await tempDirectory.exists()){
      print('Path exists');
    } else {
      print('Path does not exist, creating path');
      //TODO: Create an exception catcher maybe? LEL
      await tempDirectory.create(recursive: true);
      print('Path created');
      //or isit?
    }

    //smash everything together and pass full path into cameraController
    final path = "${photoDir.path}/$moduleCode/$fileName.png";
    print("full file path: $path");
    try{
      await cameraController.takePicture(path).then((value){
        print('Saving Photo to');
        print(path);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>PreviewScreen(imgPath: path,fileName: "$fileName.png",)));
        Fluttertoast.showToast(
            msg: "Saving photo to folder $moduleCode",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black45,
            fontSize: 16.0
        );
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Saving photo failed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black45,
          fontSize: 16.0
      );
      print('CAMERA EXCEPTION!');
      showCameraException(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if(cameras.length > 0){
        setState(() {
          selectedCameraIndex = 0;
        });
        initCamera(cameras[selectedCameraIndex]).then((value) {

        });
      } else {
        print('No camera available');
      }
    }).catchError((e){
      print('Error : ${e.code}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: cameraPreview(),
            ),
            Align(
              //flex: 1,
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 32.0, left: 5.0),
                child: BackButton(),
                ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    cameraToggle(),
                    cameraControl(context),
                    //Spacer(),
                    galleryWidget(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getCameraLensIcons(lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return CupertinoIcons.photo_camera;
      default:
        return Icons.device_unknown;
    }
  }

  onSwitchCamera() {
    selectedCameraIndex =
    selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    initCamera(selectedCamera);
  }

  showCameraException(e) {
      String errorText = 'Error ${e.code} \nError message: ${e.description}';
      print(errorText);
  }
}

class PreviewScreen extends StatefulWidget {
  final String imgPath;
  final String fileName;
  PreviewScreen({this.imgPath, this.fileName});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Image.file(File(widget.imgPath),fit: BoxFit.cover,),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.black,
                  child: Row(
                    children: <Widget>[
                      //Share Photo
                      Expanded(
                        child: FloatingActionButton(
                          heroTag: "Share",
                          child: Icon(Icons.share,color: Colors.black,),
                          backgroundColor: Colors.white,
                          onPressed: (){
                            getBytes().then((bytes) {
                              print("Share button pressed");
                              print(widget.imgPath);
                              print(bytes.buffer.asUint8List());
                              Share.file('Share via', widget.fileName, bytes.buffer.asUint8List(), 'image/path');
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: FloatingActionButton(
                        heroTag: "Crop",
                        child: Icon(Icons.crop,color: Colors.black,),
                        backgroundColor: Colors.white,
                        onPressed: (){
                          Navigator.pushNamed(
                            context,
                            "cropping",
                            arguments: CropScreenArguments(
                              '${widget.imgPath}',
                              '${widget.fileName}',
                            ),
                          );
                          },
                        ),
                      ),



                      //Go to gallery
                      Expanded(
                        child: FloatingActionButton(
                          heroTag: "Gallery",
                          child: Icon(
                            Icons.collections,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            //Navigator.pop(context);
                            final result = await MediaPicker.show(context);
                            print(result);
                            if (result != null) {
                              print("pushing Image Viewer route");
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      MediaViewerPage(media: result.
                                      selectedMedias[0])));
                            }
                          },
                        )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Future getBytes () async {
    Uint8List bytes = File(widget.imgPath).readAsBytesSync() as Uint8List;
//    print(ByteData.view(buffer))
    return ByteData.view(bytes.buffer);
  }
}