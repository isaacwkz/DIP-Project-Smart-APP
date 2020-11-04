import 'package:dip_taskplanner/Screen/StudyPage.dart';
import 'package:flutter/material.dart';
import 'package:dip_taskplanner/Screen/todo.dart';
import 'package:dip_taskplanner/Screen/coursePage.dart';
import 'package:dip_taskplanner/Screen/loadingPage.dart';
import 'package:dip_taskplanner/Screen/calendarPage.dart';
import 'package:dip_taskplanner/Screen/homePage.dart';
import 'package:dip_taskplanner/Screen/camera.dart';
import 'package:dip_taskplanner/Screen/gallery.dart';
import 'package:dip_taskplanner/Screen/cropping.dart';
import 'package:dip_taskplanner/Screen/NewCalendar.dart';

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
        "home":(context) => HomePage(),
        "loading":(context) => LoadingPage(),
        "calendar":(context) => NewCal(),
        "camera":(context) => CameraPageEntry(),
        "gallery":(context) => GalleryPageEntry(),
        "todo":(context) => todo(),
        "course":(context) => course(),
        "study":(context) => StudyPageEntry(),
        "cropping":(context) => CroppingPageEntry(),
      } ,
      home: HomePage(),
    );
  }
}


