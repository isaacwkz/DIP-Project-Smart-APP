import 'package:flutter/material.dart';
import 'package:dip_taskplanner/database/database.dart';
import 'package:dip_taskplanner/database/model/Courses.dart';
import 'package:dip_taskplanner/Screen/courseDetail.dart';

class course extends StatefulWidget {
  @override
  _courseState createState() => _courseState();
}


class _courseState extends State<course> {

  String courseId;
  String courseType;
  String courseTime;
  String courseVenue;
  String weekDay;

  @override
  initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved courses'),
      ),
      body: FutureBuilder<List<Courses>>(
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
                //print(courseId+courseType+weekDay+courseTime+courseVenue);

                return ListTile(
                  title: Text(courseId+' '+courseType),
                  leading: Text(snapshot.data[index].id.toString()),
                  subtitle: Text(weekDay+' '+courseTime+' '+courseVenue),
                  onTap: () => _navigateToDetail(context, snapshot.data[index]),
                  trailing: IconButton(
                      alignment: Alignment.center,
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        _deletecourse(snapshot.data[index]);
                        setState(() {});
                      }),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Oops!");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToCreatecourseScreen(context);
          },
          tooltip: 'Add Item',
          child: Icon(Icons.add)
      ),
    );
  }
}

_navigateToCreatecourseScreen(BuildContext context) async {
  // Navigator.push returns a Future that completes after calling
  // Navigator.pop on the Selection Screen.
  final result = await Navigator.push(
    context,
    // Create the SelectionScreen in the next step.
    MaterialPageRoute(builder: (context) => DetailcourseScreen()),
  );
  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text("$result")));
}

_deletecourse(Courses course) {
  DatabaseHelper.instance.deleteCourse(course.id);
}

_navigateToDetail(BuildContext context, Courses course) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailcourseScreen(course: course)),
  );
}

