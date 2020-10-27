
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dip_taskplanner/components/add_user_dialog.dart';
import 'package:dip_taskplanner/components/homescreen.dart';
import 'package:dip_taskplanner/components/home_presenter.dart';
import 'package:dip_taskplanner/Screen/loadingPage.dart';
import 'package:dip_taskplanner/database/model/course.dart';



class calendar extends StatefulWidget {

  @override
  _calendarState createState() => _calendarState();
}



class _calendarState extends State<calendar> with TickerProviderStateMixin {
  //Vairable Initializaton
  Map<DateTime, List> _events;
  List _selectedEvents;
  DateTime _selectedDay;

  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    print(_selectedDay);
    print(_selectedEvents);

    _events = {
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7'],
      _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }


void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
      _selectedDay=day;
      print(events);
      print(_selectedDay);
      if(events.isEmpty)
        events.add(['No course today, you may add events']);
        _events[day]=events;
        print(_events);
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          _buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.amber[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }


  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Load Course'),
              color: Color(0xFFA500),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoadingPage()),
                );
              }
            ),
            RaisedButton(
              child: Text('Course Schedule'),
              color: Color(0xFFA500),
              onPressed: () {
                Navigator.push(context,new  MaterialPageRoute(
                    builder:(context) =>new SecondScreen(
                      myCourseData: showCourseInfo,
                    ))
                );
              },
            ),
            RaisedButton(
              child: Text('Add New Events'),
              color: Color(0xFFA500),
              onPressed:() => _todoEdit(),
            ),

          ],
        ),

      ],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }

  //TO DO LIST Page
  List<String> _todoItems = [];
  void _todoEdit() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Add events'),
          leading: new BackButton(),
        ),
        body: new TextField(
          decoration: new InputDecoration(
            hintText: 'Edit Here',
            contentPadding: const EdgeInsets.all(10.0),
          ),
          onSubmitted: (text) {
            if (text.length == 0) {
              Navigator.of(context).pop();
            } else {
              _todoItemsChanged(text);
              Navigator.of(context).pop();
            }
          },
        ),
      );
    }));
  }

  //Updates new events/to-do list
  _todoItemsChanged(String text) {
    setState(() {
      _todoItems.add(text);
      _selectedEvents.add(text);

      //_events.update;
      _events[_selectedDay]= _selectedEvents;
      print(_events);
    });
  }
}
List<Course> allCourseInfo;
List<Course> showCourseInfo = [];
void getcourseInfo (){
  for (int i = 0;i < allCourseInfo.length; i++) {
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

class SecondScreen extends StatelessWidget{
  SecondScreen({@required this.myCourseData});
  final List<Course> myCourseData;
  @override
  Widget build(BuildContext context){
    DateTime today = DateTime.now();
    var weekday = today.weekday;
    double width = MediaQuery.of(context).size.width;
    List<Widget> temp1 = [];
    List<Widget> temp2 = [];
    switch(weekday){
      case 1: {
        for(int i = 0; i < myCourseData.length; i++){
          if (myCourseData[i].weekDay == 'MON'){
            temp1.add(TodaySchedule(
              courseId: myCourseData[i].courseId,
              courseVenue: myCourseData[i].courseVenue,
              eventST: myCourseData[i].eventST,
              eventET: myCourseData[i].eventET,
              category: myCourseData[i].eventCAT,
              teachingWeek: myCourseData[i].teachingWeek));
          }
          if (myCourseData[i].weekDay == 'TUE'){
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
      case 2: {
        for(int i = 0; i < myCourseData.length; i++){
          if (myCourseData[i].weekDay == 'TUE'){
            temp1.add(TodaySchedule(
                courseId: myCourseData[i].courseId,
                courseVenue: myCourseData[i].courseVenue,
                eventST: myCourseData[i].eventST,
                eventET: myCourseData[i].eventET,
                category: myCourseData[i].eventCAT,
                teachingWeek: myCourseData[i].teachingWeek));
          }
          if (myCourseData[i].weekDay == 'WED'){
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
      case 3: {
        for(int i = 0; i < myCourseData.length; i++){
          if (myCourseData[i].weekDay == 'WED'){
            temp1.add(TodaySchedule(
                courseId: myCourseData[i].courseId,
                courseVenue: myCourseData[i].courseVenue,
                eventST: myCourseData[i].eventST,
                eventET: myCourseData[i].eventET,
                category: myCourseData[i].eventCAT,
                teachingWeek: myCourseData[i].teachingWeek));
          }
          if (myCourseData[i].weekDay == 'THU'){
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
      case 4: {
        for(int i = 0; i < myCourseData.length; i++){
          if (myCourseData[i].weekDay == 'THU'){
            temp1.add(TodaySchedule(
                courseId: myCourseData[i].courseId,
                courseVenue: myCourseData[i].courseVenue,
                eventST: myCourseData[i].eventST,
                eventET: myCourseData[i].eventET,
                category: myCourseData[i].eventCAT,
                teachingWeek: myCourseData[i].teachingWeek));
          }
          if (myCourseData[i].weekDay == 'FRI'){
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
      case 5: {
        for(int i = 0; i < myCourseData.length; i++){
          if (myCourseData[i].weekDay == 'FRI'){
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
      case 7: {
        for(int i = 0; i < myCourseData.length; i++){
          if (myCourseData[i].weekDay == 'MON'){
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

    return Column(
        children: <Widget>[
          Text('Today''s schedule'),
          ListView(children: temp1),
          Text('Tomorrow''s schedule'),
          ListView(children: temp2),
          RaisedButton(
            child: Text('Back'),
            color: Color(0xFFA500),
            onPressed: () {
              Navigator.pop(context);
            },
        )
      ]
    );
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
      child:
      Stack(
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
      child:
      Stack(
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