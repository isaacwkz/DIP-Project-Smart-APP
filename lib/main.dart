import 'package:dip_taskplanner/Screen/ShowCourses.dart';
import 'package:dip_taskplanner/Screen/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:dip_taskplanner/Screen/calendarPage.dart';
import 'package:dip_taskplanner/Screen/homePage.dart';
import 'package:dip_taskplanner/Screen/camera.dart';
import 'package:dip_taskplanner/Screen/gallery2.dart';
import 'package:dip_taskplanner/Screen/cropping.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      //routes defines other pages which can be directed from homePage
      routes:{
        "loading":(context) => LoadingPage(),
        "calendar":(context) => calendar(),
        "camera":(context) => CameraPageEntry(),
        "course":(context) => showCourse(),
        //"gallery":(context) => GalleryPageEntry(),
        "gallery":(context) => GalleryExample(),
      } ,
      home: HomePage(),
    );
  }
}


