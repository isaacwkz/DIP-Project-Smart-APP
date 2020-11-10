import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dip_taskplanner/tableCalendar/table_calendar.dart';
import 'package:dip_taskplanner/Screen/webPage.dart';
import 'package:dip_taskplanner/database/model/Courses.dart';
import 'package:dip_taskplanner/Screen/coursePage.dart';
import 'package:dip_taskplanner/database/database.dart';

class NewCal extends StatefulWidget {
  @override
  _NewCalState createState() => _NewCalState();
}

class _NewCalState extends State<NewCal> with TickerProviderStateMixin {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  DateTime _selectedDay= DateTime.now();

  String courseId;
  String courseType;
  String courseTime;
  String courseVenue;
  String weekDay;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    print(_selectedDay);
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
    //_controller.setCalendarFormat(CalendarFormat.twoWeeks);
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
      _selectedDay = day;
      print(_selectedDay);
      //if (events.isEmpty) events.add(['No course today, you may add events']);
      _events[day] = events;
      print(_events);
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildTableCalendar(),
            const SizedBox(height: 2.0),
            _buildButtons(),
            //const SizedBox(height: 3.0),
            Expanded(child:_buildCourses()),
            const SizedBox(height: 8.0),
            Expanded(child: _buildEventList()),
          ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      events: _events,
      initialCalendarFormat: CalendarFormat.twoWeeks,
      startingDayOfWeek: StartingDayOfWeek.monday,

      calendarStyle: CalendarStyle(
          canEventMarkersOverflow: true,
          selectedColor: Colors.deepOrange[400],
          todayColor: Colors.deepOrange[200],
          markersColor: Colors.lightGreen[400],
          outsideDaysVisible: false,
          todayStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white)),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonDecoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20.0),
        ),
        formatButtonTextStyle: TextStyle(color: Colors.white),
        formatButtonShowsNext: false,
      ),
      onDaySelected: _onDaySelected,

      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.deepOrange[400],
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
        todayDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
      ),
      calendarController: _controller,
    );
  }
  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
                child: Text('Check Course'),
                color: Color(0xFFA500),
                onPressed: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (_) {
                        return new Browser(
                          url: "https://sso.wis.ntu.edu.sg/webexe88/owa/sso_redirect.asp?t=1&app=https://wish.wis.ntu.edu.sg/pls/webexe/aus_stars_check.check_subject_web2",
                          title: "Course Registration System",
                        );
                      }));
                }),
            RaisedButton(
                child: Text('Course Schedule'),
                color: Color(0xFFA500),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => course()),
                  );
                }),
            RaisedButton(
              child: Text('Add New Events'),
              color: Color(0xFFA500),
              onPressed: _showAddDialog,
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildCourses(){
    return FutureBuilder<List<Courses>>(
      future: DatabaseHelper.instance.retrieveCourses(),
      initialData: List(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {

              courseId=snapshot.data[index].courseId;
              courseType=snapshot.data[index].courseType;
              weekDay=snapshot.data[index].weekDay;
              courseTime=snapshot.data[index].courseTime;
              courseVenue= snapshot.data[index].courseVenue;

              if(weekDay=='Mon'&& _selectedDay.weekday==1 ) {
                print('MON');
                return ListTile(
                  title: Text(courseId+' '+courseType),
                  leading: Text('Monday'),
                  subtitle: Text(courseTime+' '+courseVenue),
                );
              }
              else if(weekDay=='Tue'&& _selectedDay.weekday==2 ) {
                print('TUE');
                return ListTile(
                  title: Text(courseId+' '+courseType),
                  leading: Text('Tuesday'),
                  subtitle: Text(courseTime+' '+courseVenue),
                );
              }
              else if(weekDay=='Wed'&& _selectedDay.weekday==3 ) {
                print('Wed');
                return ListTile(
                  title: Text(courseId+' '+courseType),
                  leading: Text('Wednesday'),
                  subtitle: Text(courseTime+' '+courseVenue),
                );
              }
              else if(weekDay=='Thu'&& _selectedDay.weekday==4 ) {
                print('Thu');
                return ListTile(
                  title: Text(courseId+' '+courseType),
                  leading: Text('Thursday'),
                  subtitle: Text(courseTime+' '+courseVenue),
                );
              }
              else if(weekDay=='Fri'&& _selectedDay.weekday==5 ) {
                print('FRI');
                return ListTile(
                  //title: Text('<'+weekDay + '>'+' ' + courseTime + ' ' + courseVenue+ ' ' +'['+ courseId + ' ' + courseType+']'),
                  title: Text(courseId+' '+courseType),
                  leading: Text('Friday'),
                  subtitle: Text(courseTime+' '+courseVenue),
                );
              }
              else{
                return ListTile(title:Text(' '));
                //return null;
              }
            },
          );
        } else if (snapshot.hasError) {
          return Text("Oops!");
        }
        return Center(child: CircularProgressIndicator());
      },
    );

  }
  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) =>
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.8),
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              title: Text(event.toString()),
              onTap: () => print('$event tapped!'),
            ),
          ))
          .toList(),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add Event'),
          content: TextField(
            controller: _eventController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (_eventController.text.isEmpty) return;
                if (_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay]
                      .add(_eventController.text);
                } else {
                  _events[_controller.selectedDay] = [
                    _eventController.text
                  ];
                }
                prefs.setString("events", json.encode(encodeMap(_events)));
                _eventController.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(onPressed: () => Navigator.pop(context),
                child: Text('Cancel')),
          ],
        ));
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
    });
  }

}