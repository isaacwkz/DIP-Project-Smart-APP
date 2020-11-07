import 'package:flutter/material.dart';

import 'package:flutter_dnd/flutter_dnd.dart';

class StudyMode extends StatefulWidget {
  @override
  _StudyModeState createState() => _StudyModeState();
}

class _StudyModeState extends State<StudyMode> with WidgetsBindingObserver {
  String _filterName = '';
  bool _isNotificationPolicyAccessGranted = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state.toString());
    if (state == AppLifecycleState.resumed) {
      updateUI();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateUI();
  }

  void updateUI() async {
    int filter = await FlutterDnd.getCurrentInterruptionFilter();
    String filterName = FlutterDnd.getFilterName(filter);
    bool isNotificationPolicyAccessGranted =
    await FlutterDnd.isNotificationPolicyAccessGranted;

    setState(() {
      _isNotificationPolicyAccessGranted = isNotificationPolicyAccessGranted;
      _filterName = filterName;
    });
  }

  void setInterruptionFilter(int filter) async {
    if (await FlutterDnd.isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(filter);
      updateUI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DO NOT DISTURB'),
        ),

        body: Center(
          child:
          Container(
              decoration: new BoxDecoration(
                color: Colors.black,
                border: new Border.all(width: 2.0, color: Colors.black),
                borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                image: new DecorationImage(
                  image: new AssetImage("lib/Assets/studymode_pic.jpg"),
    ),
    ),
    alignment: Alignment.center,
          child:
            (
          Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Text('Current Filter: $_filterName'),
            SizedBox(
              height: 10,
            ),
            Text(
                'isNotificationPolicyAccessGranted: ${_isNotificationPolicyAccessGranted ? 'YES' : 'NO'}'),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                FlutterDnd.gotoPolicySettings();
              },
              color: Color(0x1F415D),
              child: Text('GOTO POLICY SETTINGS',
                  style: TextStyle(
                  color: Colors.white, fontSize: 16.0),),
            ),
            RaisedButton(
              onPressed: () async {
                setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
              },
              color: Color(0x1F415D),
              child: Text('TURN ON DND',
                style: TextStyle(
                  color: Colors.white, fontSize: 16.0),),
            ),
            RaisedButton(
              onPressed: () {
                setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
              },
              color: Color(0x1F415D),
              child: Text('TURN OFF DND',
                style: TextStyle(
                    color: Colors.white, fontSize: 16.0),),
            ),
            RaisedButton(
              onPressed: () {
                setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALARMS);
              },
              color: Color(0x1F415D),
              child: Text('TURN ON DND - ALLOW ALARM',
                style: TextStyle(
                    color: Colors.white, fontSize: 16.0),),
            ),
            RaisedButton(
              onPressed: () {
                setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_PRIORITY);
              },
              color: Color(0x1F415D),
              child: Text('TURN ON DND - ALLOW PRIORITY',
                style: TextStyle(
                    color: Colors.white, fontSize: 16.0),),
            )
          ])
    )
          )
          )
        );

  }
}