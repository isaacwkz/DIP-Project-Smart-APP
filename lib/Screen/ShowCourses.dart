import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dip_taskplanner/components/add_user_dialog.dart';
import 'package:dip_taskplanner/components/homescreen.dart';
import 'package:dip_taskplanner/components/home_presenter.dart';
import 'package:dip_taskplanner/Screen/loadingPage.dart';
import 'package:dip_taskplanner/database/model/course.dart';
import 'package:dip_taskplanner/components/regExp.dart';
import 'package:dip_taskplanner/database/database_hepler.dart';
import 'package:dip_taskplanner/Screen/calendarPage.dart';
import 'package:dip_taskplanner/database/model/course.dart';

/*
void getcourseInfo() {
  for (int i = 0; i < allCourseInfo.length; i++) {
    showCourseInfo.add(new Course(
      allCourseInfo[i].courseId,
      allCourseInfo[i].courseName,
      allCourseInfo[i].courseVenue,
      allCourseInfo[i].eventST,
      allCourseInfo[i].eventET,
      allCourseInfo[i].eventCAT,
      allCourseInfo[i].weekDay,
      allCourseInfo[i].teachingWeek,
      allCourseInfo[i].courseType,
      allCourseInfo[i].academicUnit,
      allCourseInfo[i].name,
    ));
  }
}

 */


class showCourse extends StatefulWidget {
  @override
  _showCourseState createState() => _showCourseState();
}

class _showCourseState extends State<showCourse> {

  final databasehelper = DatabaseHelper();
  List<Course> myCourseData;
  List<Course> allCourseInfo;
  List<Course> showCourseInfo = [];

  @override
  void initState() {
    super.initState();
    setState(() {});
    getAllCourseInfo();
  }

  Future<void> getAllCourseInfo() async {
    allCourseInfo = await databasehelper.getCourse();
    print(allCourseInfo.toString());
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    var weekday = today.weekday;
    double width = MediaQuery.of(context).size.width;
    List<Widget> temp1 = [];
    List<Widget> temp2 = [];

    switch (weekday) {
      case 1:
        {
          for (int i = 0; i < myCourseData.length; i++) {
            if (myCourseData[i].weekDay == 'MON') {
              temp1.add(TodaySchedule(
                  courseId: myCourseData[i].courseId,
                  courseVenue: myCourseData[i].courseVenue,
                  eventST: myCourseData[i].eventST,
                  eventET: myCourseData[i].eventET,
                  category: myCourseData[i].eventCAT,
                  teachingWeek: myCourseData[i].teachingWeek));
            }
            if (myCourseData[i].weekDay == 'TUE') {
              temp2.add(TomorrowSchedule(
                  courseId: myCourseData[i].courseId,
                  courseVenue: myCourseData[i].courseVenue,
                  eventST: myCourseData[i].eventST,
                  eventET: myCourseData[i].eventET,
                  category: myCourseData[i].eventCAT,
                  teachingWeek: myCourseData[i].teachingWeek));
            }
          }
        }
        break;
      case 2:
        {
          for (int i = 0; i < myCourseData.length; i++) {
            if (myCourseData[i].weekDay == 'TUE') {
              temp1.add(TodaySchedule(
                  courseId: myCourseData[i].courseId,
                  courseVenue: myCourseData[i].courseVenue,
                  eventST: myCourseData[i].eventST,
                  eventET: myCourseData[i].eventET,
                  category: myCourseData[i].eventCAT,
                  teachingWeek: myCourseData[i].teachingWeek));
            }
            if (myCourseData[i].weekDay == 'WED') {
              temp2.add(TomorrowSchedule(
                  courseId: myCourseData[i].courseId,
                  courseVenue: myCourseData[i].courseVenue,
                  eventST: myCourseData[i].eventST,
                  eventET: myCourseData[i].eventET,
                  category: myCourseData[i].eventCAT,
                  teachingWeek: myCourseData[i].teachingWeek));
            }
          }
        }
        break;
      case 3:
        {
          for (int i = 0; i < myCourseData.length; i++) {
            if (myCourseData[i].weekDay == 'WED') {
              temp1.add(TodaySchedule(
                  courseId: myCourseData[i].courseId,
                  courseVenue: myCourseData[i].courseVenue,
                  eventST: myCourseData[i].eventST,
                  eventET: myCourseData[i].eventET,
                  category: myCourseData[i].eventCAT,
                  teachingWeek: myCourseData[i].teachingWeek));
            }
            if (myCourseData[i].weekDay == 'THU') {
              temp2.add(TomorrowSchedule(
                  courseId: myCourseData[i].courseId,
                  courseVenue: myCourseData[i].courseVenue,
                  eventST: myCourseData[i].eventST,
                  eventET: myCourseData[i].eventET,
                  category: myCourseData[i].eventCAT,
                  teachingWeek: myCourseData[i].teachingWeek));
            }
          }
        }
        break;
      case 4:
        {
          for (int i = 0; i < myCourseData.length; i++) {
            if (myCourseData[i].weekDay == 'THU') {
              temp1.add(TodaySchedule(
                  courseId: myCourseData[i].courseId,
                  courseVenue: myCourseData[i].courseVenue,
                  eventST: myCourseData[i].eventST,
                  eventET: myCourseData[i].eventET,
                  category: myCourseData[i].eventCAT,
                  teachingWeek: myCourseData[i].teachingWeek));
            }
            if (myCourseData[i].weekDay == 'FRI') {
              temp2.add(TomorrowSchedule(
                  courseId: myCourseData[i].courseId,
                  courseVenue: myCourseData[i].courseVenue,
                  eventST: myCourseData[i].eventST,
                  eventET: myCourseData[i].eventET,
                  category: myCourseData[i].eventCAT,
                  teachingWeek: myCourseData[i].teachingWeek));
            }
          }
        }
        break;
      case 5:
        {
          for (int i = 0; i < myCourseData.length; i++) {
            if (myCourseData[i].weekDay == 'FRI') {
              temp1.add(TodaySchedule(
                  courseId: myCourseData[i].courseId,
                  courseVenue: myCourseData[i].courseVenue,
                  eventST: myCourseData[i].eventST,
                  eventET: myCourseData[i].eventET,
                  category: myCourseData[i].eventCAT,
                  teachingWeek: myCourseData[i].teachingWeek));
            }
          }
        }
        break;
      case 7:
        {
          for (int i = 0; i < myCourseData.length; i++) {
            if (myCourseData[i].weekDay == 'MON') {
              temp2.add(TomorrowSchedule(
                  courseId: myCourseData[i].courseId,
                  courseVenue: myCourseData[i].courseVenue,
                  eventST: myCourseData[i].eventST,
                  eventET: myCourseData[i].eventET,
                  category: myCourseData[i].eventCAT,
                  teachingWeek: myCourseData[i].teachingWeek));
            }
          }
        }
        break;
    }

    return Column(children: <Widget>[
      SizedBox(
        height: 200, // constrain height
        child:  TodaySchedule(),
      ),
      SizedBox(
        height: 200,
        child: ListView(children: temp1),
      ),
      RaisedButton(
        child: Text('Back'),
        color: Color(0xFFA500),
        onPressed: () {
          print("Today"+ temp1.toString());
          print(myCourseData.toString());
          Navigator.pop(context);
        },
      ),
      RaisedButton(
        child: Text('Today'),
        color: Color(0xFFA500),
        onPressed: () => TodaySchedule(),
      )
    ]);
  }
}

class TodaySchedule extends StatelessWidget {
  TodaySchedule(
      {this.courseId,
        this.courseVenue,
        this.eventST,
        this.eventET,
        this.category,
        this.teachingWeek});
  final courseId;
  final courseVenue;
  final eventST;
  final eventET;
  final category;
  final teachingWeek;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: 124.0,
            margin: EdgeInsets.only(left: 35.0),
            child: Row(
              children: [
                SizedBox(width: 40.0),
                Expanded(
                  flex: 7,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '$courseId\n$courseVenue\n$eventST\n$eventET\n$category\n$teachingWeek',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class TomorrowSchedule extends StatelessWidget {
  TomorrowSchedule(
      {this.courseId,
        this.courseVenue,
        this.eventST,
        this.eventET,
        this.category,
        this.teachingWeek});
  final courseId;
  final courseVenue;
  final eventST;
  final eventET;
  final category;
  final teachingWeek;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: 124.0,
            margin: EdgeInsets.only(left: 35.0),
            child: Row(
              children: [
                SizedBox(width: 40.0),
                Expanded(
                  flex: 7,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '$courseId\n$courseVenue\n$eventST\n$eventET\n$category\n$teachingWeek',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}