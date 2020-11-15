
import 'package:dip_taskplanner/Screen/StudyPage.dart';
import 'package:dip_taskplanner/Screen/camera.dart';
import 'package:dip_taskplanner/Screen/todo.dart';
import 'package:dip_taskplanner/components/quad_clipper.dart';
import 'package:dip_taskplanner/picker/media.dart';
import 'package:dip_taskplanner/theme/color/light_color.dart';
import 'package:flutter/material.dart';
import 'package:dip_taskplanner/Screen/calendarPage.dart';
import 'package:dip_taskplanner/picker/picker.dart';
import 'package:dip_taskplanner/picker/collections.dart';
import 'package:dip_taskplanner/Screen/NewCalendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//This page is homepage
class _HomePageState extends State<HomePage> {
  //HomePage({Key key}) : super(key: key);

  double width;

  Widget _header(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 160,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.purple,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, LightColor.lightpurple)),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .5, LightColor.darkpurple)),
              Positioned(
                  top: -180,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 40,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Student Management APP for SMART-APP Project",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.home,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )))
            ],
          )),
    );
  }

  Widget _circularContainer(double height, Color color, {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _categoryRow(String title, Color primary, Color textColor,) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: LightColor.orange, fontWeight: FontWeight.bold),
          ),
          _chip("See all", primary)
        ],
      ),
    );
  }

  Widget _featuredRowA() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _card(
              primary: LightColor.orange,
              backWidget:
              _decorationContainerA(LightColor.lightOrange, 50, -30),
              chipColor: LightColor.orange,
              chipText1: "This APP helps you have better time management",
              chipText2: "HOME PAGE",
              isPrimaryCard: true,
              imgPath: 'lib/Assets/ntu.png',
            ),
            _card(
              primary: Colors.white,
              chipColor: LightColor.darkBlue,
              backWidget: _decorationContainerB(Colors.white, 90, -40),
              chipText1: "Store your course timetable to calendar",
              chipText2: "CALENDAR",
              imgPath: 'lib/Assets/calendar.png',
            ),
            _card(
                primary: Colors.white,
                chipColor: LightColor.lightOrange,
                backWidget: _decorationContainerC(Colors.white, 50, -30),
                chipText1: "Store and sorting your course material",
                chipText2: "FILE SORTING",
                imgPath:'lib/Assets/file.jpg',
                ),
            _card(
                primary: Colors.white,
                chipColor: LightColor.darkBlue,
                backWidget: _decorationContainerD(LightColor.seeBlue, -50, 30,
                    secondary: LightColor.lightseeBlue,
                    secondaryAccent: LightColor.darkseeBlue),
                chipText1: "Study mode helps you focus",
                chipText2: "STUDY MODE",
                imgPath: 'lib/Assets/study.png',
              ),
          ],
        ),
      ),
    );
  }

  Color buttonColor1 = LightColor.orange;
  Color buttonColor2 = LightColor.seeBlue;
  Color buttonColor3 = LightColor.yellow;
  Color buttonColor4 = LightColor.lightpurple;
  Widget _buildButtons(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  splashColor: buttonColor2,
                  color: buttonColor2,
                  child: new Row(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Check your timetable here",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      new Expanded(
                        child: Container(),
                      ),
                      new Transform.translate(
                        offset: Offset(15.0, 0.0),
                        child: new Container(
                          padding: const EdgeInsets.all(5.0),
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(28.0)),
                            splashColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "calendar");
                              print('calendar');
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "calendar");
                    print('calendar');
                  },

                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  splashColor: buttonColor1,
                  color: buttonColor1,
                  child: new Row(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Check your to-do list here",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      new Expanded(
                        child: Container(),
                      ),
                      new Transform.translate(
                        offset: Offset(15.0, 0.0),
                        child: new Container(
                          padding: const EdgeInsets.all(5.0),
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(28.0)),
                            splashColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => todo()));
                              print("todo page");
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  //onPressed: () => {},
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => todo()),);
                    print("todo page");
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  splashColor: buttonColor3,
                  color: buttonColor3,
                  child: new Row(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Sorting your course file here",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      new Expanded(
                        child: Container(),
                      ),
                      new Transform.translate(
                        offset: Offset(15.0, 0.0),
                        child: new Container(
                          padding: const EdgeInsets.all(5.0),
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(28.0)),
                            splashColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward,
                            ),
                            onPressed: () async {
                              //Navigator.pushNamed(context, "gallery");
                                final result = await MediaPicker.show(context);
                                if (result != null) {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          MediaViewerPage(media: result.
                                          selectedMedias[0])));
                                }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  onPressed: () async {
                    //Navigator.pushNamed(context, "gallery");
                    final result = await MediaPicker.show(context);
                    if (result != null) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              MediaViewerPage(media: result
                                  .selectedMedias[0])));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  splashColor: buttonColor4,
                  color: buttonColor4,
                  child: new Row(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Study Mode",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      new Expanded(
                        child: Container(),
                      ),
                      new Transform.translate(
                        offset: Offset(15.0, 0.0),
                        child: new Container(
                          padding: const EdgeInsets.all(5.0),
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(28.0)),
                            splashColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward,
                            ),
                            onPressed: () => { Navigator.pushNamed(context, "study")},
                          ),
                        ),
                      )
                    ],
                  ),
                  onPressed: () => { Navigator.pushNamed(context, "study")},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _card(
      {Color primary = Colors.redAccent,
      String imgPath,
      String chipText1 = '',
      String chipText2 = '',
      Widget backWidget,
      Color chipColor = LightColor.orange,
      bool isPrimaryCard = false}) {
    return Container(
        height: isPrimaryCard ? 190 : 180,
        width: isPrimaryCard ? width * .32 : width * .32,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: primary.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: LightColor.lightpurple.withAlpha(20))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            child: Stack(
              children: <Widget>[
                backWidget,
                Positioned(
                    top: 20,
                    left: 0,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      //backgroundImage: NetworkImage(imgPath),
                      backgroundImage: AssetImage(imgPath),
                    ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: _cardInfo(chipText1, chipText2,
                      LightColor.titleTextColor, chipColor,
                      isPrimaryCard: isPrimaryCard),
                )
              ],
            ),
          ),
        ));
  }

  Widget _cardInfo(String title, String courses, Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            width: width * .32,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isPrimaryCard ? Colors.white : textColor),
            ),
          ),
          SizedBox(height: 5),
          _chip(courses, primary, height: 5, isPrimaryCard: isPrimaryCard)
        ],
      ),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  Widget _decorationContainerA(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: primary.withAlpha(200),
          ),
        ),
        _smallContainer(primary, 20, 40),
        Positioned(
          top: 20,
          right: -30,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerB(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          right: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue.shade100,
            child: CircleAvatar(radius: 30, backgroundColor: primary),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.lightseeBlue, radius: 40)))
      ],
    );
  }

  Widget _decorationContainerC(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.orange.withAlpha(100),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.orange, radius: 40))),
        _smallContainer(
          LightColor.yellow,
          35,
          70,
        )
      ],
    );
  }

  Widget _decorationContainerD(Color primary, double top, double left, {Color secondary, Color secondaryAccent}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: secondary,
          ),
        ),
        _smallContainer(LightColor.yellow, 18, 35, radius: 30),
        Positioned(
          top: 130,
          left: -50,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: primary,
            child: CircleAvatar(radius: 50, backgroundColor: secondaryAccent),
          ),
        ),
        Positioned(
          top: -30,
          right: -40,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerE(Color primary, double top, double left, {Color secondary}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: primary.withAlpha(100),
          ),
        ),
        Positioned(
            top: 40,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: primary, radius: 40))),
        Positioned(
            top: 45,
            right: -50,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: secondary, radius: 50))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }


  Positioned _smallContainer(Color primary, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primary.withAlpha(255),
        ));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
  }

  //Overall desgin build structure
  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        //backgroundColor: Colors.grey,
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: LightColor.purple,
          unselectedItemColor: Colors.grey.shade300,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          //currentIndex: _selectedIndex;
          items: [
            _bottomIcons(Icons.home),
            _bottomIcons(Icons.event),
            _bottomIcons(Icons.add_a_photo),
            _bottomIcons(Icons.star_border),
          ],
          onTap: (index) {
            if(index==0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewCal()));
            }
            else if(index==1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewCal()));
            }
            else if(index==2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CameraPageEntry()));
            }
            else
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StudyPageEntry()));
            }
            },
        ),
        body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  _header(context),
                  SizedBox(height: 20),
                  _categoryRow(
                      "Features:", LightColor.orange, LightColor.orange),
                  _featuredRowA(),
                  _buildButtons(context),
                  SizedBox(height: 0),
                ],
              ),
            )));
  }
}
