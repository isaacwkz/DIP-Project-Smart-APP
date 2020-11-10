import 'package:flutter/material.dart';
import 'package:dip_taskplanner/database/model/Courses.dart';
import 'package:dip_taskplanner/database/database.dart';


class DetailcourseScreen extends StatefulWidget {
  static const routeName = '/detailcourseScreen';
  final Courses course;

  const DetailcourseScreen({Key key, this.course}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateCoursesState(course);
}

class _CreateCoursesState extends State<DetailcourseScreen> {
  Courses course;
  final weekDayTextController = TextEditingController();
  final courseIDTextController = TextEditingController();
  final courseVenueTextController = TextEditingController();
  final courseTimeTextController = TextEditingController();
  final courseTypeTextController = TextEditingController();

  _CreateCoursesState(this.course);

  @override
  void initState() {
    super.initState();
    if (course != null) {
      weekDayTextController.text = course.weekDay;
      courseIDTextController.text = course.courseId;
      courseVenueTextController.text = course.courseVenue;
      courseTimeTextController.text = course.courseTime;
      courseTypeTextController.text = course.courseType;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('course detail'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "weekDay (Mon,Tue,Wed,Thu,Fri)"),
              maxLines: 1,
              controller: weekDayTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "CourseId"),
              maxLines: 1,
              controller: courseIDTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
            decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: "CourseVenue"),
            maxLines: 1,
            controller: courseVenueTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "CourseTime"),
              maxLines: 1,
              controller: courseTimeTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "CourseType"),
              maxLines: 1,
              controller: courseTypeTextController,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () async {
            _savecourse(weekDayTextController.text, courseIDTextController.text,
                courseVenueTextController.text, courseTimeTextController.text,
                courseTypeTextController.text);
            setState(() {});
          }),
    );
  }


  _savecourse(String weekDay, String courseId,String courseVenue,String courseTime,String courseType) async {
    if (course == null) {
      DatabaseHelper.instance.insertCourses(Courses(
          weekDay: weekDayTextController.text,
          courseId: courseIDTextController.text,
          courseVenue: courseVenueTextController.text,
          courseTime: courseTimeTextController.text,
          courseType: courseTypeTextController.text,
      ));
      Navigator.pushNamed(context, "calendar");
      print('insert testing');
      print(course);
    }
    else {
      await DatabaseHelper.instance
          .updateCourse(Courses(id: course.id, weekDay: weekDay, courseId: courseId,courseVenue: courseVenue,courseTime: courseTime,courseType: courseType));
      //Navigator.pop(context);
      Navigator.pushNamed(context, "calendar");
      print('update testing');
      print(course);
    }
  }
}
