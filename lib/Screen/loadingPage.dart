import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dip_taskplanner/Screen/webPage.dart';
import 'package:dip_taskplanner/Screen/homepage.dart';



class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  String state = 'Loading Files';
  bool exist = false;
  final dateController = TextEditingController();
  final myTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Center(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('lib/Assets/Sample.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0),
                    child: TextField(controller: dateController,
                      decoration: InputDecoration(
                          hintText: 'Type here (DDMMYYYY)',
                          labelText: 'Input Semester Starting Date'),),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: new RaisedButton(
                          child: Text(
                            "Check Your Course Registed (School Website)",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16.0),
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
                    padding: const EdgeInsets.only(left: 0.0),
                    child: new RaisedButton(
                        child: Text(
                          "Return To HomePage Without Loading Course",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        color: Color(0x1F415D),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return HomePage();
                              }));
                        }),
                  ),
                ]
            )
        ),
      ),
    );
  }


}





