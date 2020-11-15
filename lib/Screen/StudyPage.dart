
import 'package:dip_taskplanner/components/StudyMode.dart';
import 'package:dip_taskplanner/components/MUsicPlayer.dart';
import 'package:dip_taskplanner/theme/color/light_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:flutter/cupertino.dart';

class StudyPageEntry extends StatefulWidget {
  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPageEntry> {


  Color buttonColor1 = LightColor.orange;
  Color buttonColor2 = LightColor.seeBlue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Study Page'),
        ),
       body: Column(
          children: <Widget>[
          Container(
            width: 300,
            height: 250,
            color: Colors.black,
            child: Image.asset("lib/Assets/music.jpg"),
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
                            "Music Player",
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
                            onPressed: () => {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => MusicPLayer()),)
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  //onPressed: () => {},
                    onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MusicPLayer()),)
                    },
                ),
              ),
            ],
          ),
        ),
          Container(
          width: 300,
          height: 250,
          color: Colors.black,
          child: Image.asset("lib/Assets/study_pic.jpg"),
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
                  splashColor: buttonColor2,
                  color: buttonColor2,
                  child: new Row(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Study Mode (Silence)",
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
                                  builder: (context) => StudyMode()),);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  //onPressed: () => {},
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => StudyMode()),);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
 }



