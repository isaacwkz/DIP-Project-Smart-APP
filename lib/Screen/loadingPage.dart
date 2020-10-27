import 'package:dip_taskplanner/database/database_hepler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dip_taskplanner/Screen/CalendarOld.dart';
import 'package:dip_taskplanner/components/regExp.dart';
import 'package:dip_taskplanner/Screen/webPage.dart';
import 'package:dip_taskplanner/Screen/calendarPage.dart';
import 'package:dip_taskplanner/Screen/homepage.dart';


class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  var databasehelper = DatabaseHelper();
  String state = 'Loading Files';
  bool exist = false;
  final dateController = TextEditingController();
  final myTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    existence();
  }
  Future<void> existence () async{
    bool exist = await databasehelper.coursesExist();
    print(exist);
    setState((){
      if(exist) state = '2';
      else state = '2';
    });
  }
  @override
  Widget build(BuildContext context) {
    return getOption();
  }

  Widget getOption (){
    switch (state) {
      //case '1': return CalendarPage();
      case '2': return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset('lib/Assets/Sample.jpeg'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:0.0, horizontal: 20.0),
                  child: TextField(controller: dateController,decoration: InputDecoration(hintText: 'Type here (DDMMYYYY)',labelText:'Input Semester Starting Date' ) ,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:0.0, horizontal: 20.0),
                  child: TextField(controller: myTextController,decoration: InputDecoration(hintText: 'Paste your course here',labelText:'Print/Check Courses Registered' ) ,),
                ),
                Padding(
                    padding: const EdgeInsets.only(left:0.0),
                    child: new RaisedButton(
                        child: Text(
                          "Check Your Course Registed (School Website)",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        color: Color(0x1F415D),
                        onPressed: () {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (_) {
                            return new Browser(
                              url: "https://sso.wis.ntu.edu.sg/webexe88/owa/sso_redirect.asp?t=1&app=https://wish.wis.ntu.edu.sg/pls/webexe/aus_stars_check.check_subject_web2",
                              title: "Course Registration System",
                            );
                          }));
                        })
                ),
                Padding(
                    padding: const EdgeInsets.only(left:0.0),
                    child: new RaisedButton(
                        child: Text(
                          "Delete previous course information and reload",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        color: Color(0x1F415D),
                        onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('ARE YOU SURE TO DELETE ALL?'),
                                content: Text('This will be irreversible.'),
                                actions: [
                                  FlatButton(
                                    onPressed: () async {
                                      await databasehelper.coursesExist();
                                      await databasehelper.usersExist();
                                      databasehelper.deleteAllUsers();
                                      databasehelper.deleteAllCourses();
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoadingPage()));
                                    },
                                    child: Text('Yes'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No'),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                ),
                Padding(
                    padding: const EdgeInsets.only(left:0.0),
                    child: new RaisedButton(
                        child: Text(
                          "Return To HomePage Without Loading Course",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        color: Color(0x1F415D),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) { return  HomePage();}));
                        }),
                ),
                Row(
                  
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: FlatButton(onPressed: (){
                        final func = ListOfCourses();
                        if(myTextController.text.isNotEmpty){
                          bool check = func.addToDatabase(myTextController.text,context);
                          if(check){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return  HomePage();
                                },
                              ),
                            );
                          }
                          else{
                              showDialog(
                              context: context,
                              builder: (context)=> AlertDialog(
                                title: Text('Error'),
                                content: Text('Please copy and paste your Courses Registered correctly.'),
                                actions: [
                                  FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Okay'))
                                ],
                              ),
                              barrierDismissible: false
                            );
                          }

                        }
                        else{
                          showDialog(
                            context: context,
                            builder: (_)=>
                              AlertDialog(
                                title: Text('Error'),
                                content: Text('Please do not leave it empty and \ncopy-paste your Courses Registered.'),
                                actions: [
                                  FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Okay'))
                                ],
                              ),
                              barrierDismissible: false
                            );
                        }
                      }, 
                      child: Text('Submit'),),
                    ),flex:1),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(right:24.0),
                      child: FlatButton(onPressed: (){myTextController.clear();}, child: Text('Clear'),),
                    ),flex:1),
                  ],
                ),
              ],
            )
          ),
        ),
    ),
      );
        break;
      default: return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(state.toString())
          ],
        ))),
      );break;
    }
  }

  }








