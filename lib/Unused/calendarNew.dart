import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';

//Gain the events from API
//FOR Future use only
Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  String status;
  String message;
  List<Datum> data;

  Event({
    this.status,
    this.message,
    this.data,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String kodeEvent;
  DateTime tanggalEvent;
  String judulEvent;
  String lokasiEvent;
  String isiEvent;
  String fotoEvent;
  String waktuEvent;
  String statusEvent;
  String createBy;
  DateTime createTime;
  String updateBy;
  String updateTime;

  Datum({
    this.kodeEvent,
    this.tanggalEvent,
    this.judulEvent,
    this.lokasiEvent,
    this.isiEvent,
    this.fotoEvent,
    this.waktuEvent,
    this.statusEvent,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kodeEvent: json["kodeEvent"],
        tanggalEvent: DateTime.parse(json["tanggalEvent"]),
        judulEvent: json["judulEvent"],
        lokasiEvent: json["lokasiEvent"],
        isiEvent: json["isiEvent"],
        fotoEvent: json["fotoEvent"],
        waktuEvent: json["waktuEvent"],
        statusEvent: json["statusEvent"],
        createBy: json["createBy"],
        createTime: DateTime.parse(json["createTime"]),
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() => {
        "kodeEvent": kodeEvent,
        "tanggalEvent":
            "${tanggalEvent.year.toString().padLeft(4, '0')}-${tanggalEvent.month.toString().padLeft(2, '0')}-${tanggalEvent.day.toString().padLeft(2, '0')}",
        "judulEvent": judulEvent,
        "lokasiEvent": lokasiEvent,
        "isiEvent": isiEvent,
        "fotoEvent": fotoEvent,
        "waktuEvent": waktuEvent,
        "statusEvent": statusEvent,
        "createBy": createBy,
        "createTime": createTime.toIso8601String(),
        "updateBy": updateBy,
        "updateTime": updateTime,
      };
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List _selectedEvents;
  int _counter = 0;
  Map<DateTime, List> _events;
  CalendarController _calendarController;
  AnimationController _animationController;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<List<EventModel>> getAllEvent() async {
    try {
      //final response = await http.get(_baseUrl);

      String responseString = '''
{
    "status": "ok",
    "message": "Event Is Found",
    "data": [
        {
            "kodeEvent": "1",
            "tanggalEvent": "2020-01-15",
            "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
            "lokasiEvent": "Lombok",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8cd198530_202002181405.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "0",
            "createTime": "2020-01-29 16:37:26",
            "updateBy": "",
            "updateTime": "2020-02-18 14:05:53"
        },
        {
            "kodeEvent": "2",
            "tanggalEvent": "2020-03-31",
            "judulEvent": "Bangun Kembali 100 Masjid dan Mushalla Anti Gempa",
            "lokasiEvent": "Jakarta",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8d3d74b44_202002181407.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "",
            "createTime": "2020-02-18 14:07:41",
            "updateBy": "",
            "updateTime": "0000-00-00 00:00:00"
        },
        {
            "kodeEvent": "3",
            "tanggalEvent": "2020-01-31",
            "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
            "lokasiEvent": "Bandung",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "",
            "createTime": "2020-02-18 14:08:34",
            "updateBy": "",
            "updateTime": "0000-00-00 00:00:00"
        }      
    ]
}
    ''';

      final Map<String, dynamic> responseJson = json.decode(responseString);
      if (responseJson["status"] == "ok") {
        List eventList = responseJson['data'];
        final result = eventList
            .map<EventModel>((json) => EventModel.fromJson(json))
            .toList();
        return result;
      } else {
        //throw CustomError(responseJson['message']);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Map<DateTime, List>> getTask1() async {
    Map<DateTime, List> mapFetch = {};
    List<EventModel> event = await getAllEvent();
    for (int i = 0; i < event.length; i++) {
      var createTime = DateTime(event[i].createTime.year,
          event[i].createTime.month, event[i].createTime.day);
      var original = mapFetch[createTime];
      if (original == null) {
        print("null");
        mapFetch[createTime] = [event[i].tanggalEvent];
      } else {
        print(event[i].tanggalEvent);
        mapFetch[createTime] = List.from(original)
          ..addAll([event[i].tanggalEvent]);
      }
    }

    return mapFetch;
  }

  Future<Map<DateTime, List>> getTask() async {
    Map<DateTime, List> mapFetch = {};

    await Future.delayed(const Duration(seconds: 3), () {});

    /*String link = baseURL + fetchTodoByDate;
    var res = await http.post(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      // need help in creating fetch logic here
    }*/

    String responseString = '''
{
    "status": "ok",
    "message": "Event Is Found",
    "data": [
        {
            "kodeEvent": "1",
            "tanggalEvent": "2020-01-15",
            "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
            "lokasiEvent": "Lombok",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8cd198530_202002181405.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "0",
            "createTime": "2020-01-29 16:37:26",
            "updateBy": "",
            "updateTime": "2020-02-18 14:05:53"
        },
        {
            "kodeEvent": "2",
            "tanggalEvent": "2020-03-31",
            "judulEvent": "Bangun Kembali 100 Masjid dan Mushalla Anti Gempa",
            "lokasiEvent": "Jakarta",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8d3d74b44_202002181407.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "",
            "createTime": "2020-02-18 14:07:41",
            "updateBy": "",
            "updateTime": "0000-00-00 00:00:00"
        },
        {
            "kodeEvent": "3",
            "tanggalEvent": "2020-01-31",
            "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
            "lokasiEvent": "Bandung",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "",
            "createTime": "2020-02-18 14:08:34",
            "updateBy": "",
            "updateTime": "0000-00-00 00:00:00"
        }      
    ]
}
    ''';

    Event event = eventFromJson(responseString);

    for (int i = 0; i < event.data.length; i++) {
      var createTime = DateTime(event.data[i].createTime.year,
          event.data[i].createTime.month, event.data[i].createTime.day);
      var original = mapFetch[createTime];
      if (original == null) {
        print("null");
        mapFetch[createTime] = [event.data[i].tanggalEvent];
      } else {
        print(event.data[i].tanggalEvent);
        mapFetch[createTime] = List.from(original)
          ..addAll([event.data[i].tanggalEvent]);
      }
    }

    return mapFetch;
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  void initState() {
    final _selectedDay = DateTime.now();
    _selectedEvents = [];
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTask1().then((val) => setState(() {
            _events = val;
          }));
      //print( ' ${_events.toString()} ');
    });
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTableCalendarWithBuilders(),
            const SizedBox(height: 8.0),
            const SizedBox(height: 8.0),
            Expanded(child: _buildEventList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      //locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      //holidays: _holidays,
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

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      /*onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },*/
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
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

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
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
}

class EventModel {
  String kodeEvent;
  DateTime tanggalEvent;
  String judulEvent;
  String lokasiEvent;
  String isiEvent;
  String fotoEvent;
  String waktuEvent;
  String statusEvent;
  String createBy;
  DateTime createTime;
  String updateBy;
  String updateTime;

  EventModel({
    this.kodeEvent,
    this.tanggalEvent,
    this.judulEvent,
    this.lokasiEvent,
    this.isiEvent,
    this.fotoEvent,
    this.waktuEvent,
    this.statusEvent,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        kodeEvent: json["kodeEvent"],
        tanggalEvent: DateTime.parse(json["tanggalEvent"]),
        judulEvent: json["judulEvent"],
        lokasiEvent: json["lokasiEvent"],
        isiEvent: json["isiEvent"],
        fotoEvent: json["fotoEvent"],
        waktuEvent: json["waktuEvent"],
        statusEvent: json["statusEvent"],
        createBy: json["createBy"],
        createTime: DateTime.parse(json["createTime"]),
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
      );
}