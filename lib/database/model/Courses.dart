class Courses {
  final int id;
  final String weekDay;
  final String courseId;
  final String courseVenue;
  final String courseTime;
  final String courseType;
  static const String TABLENAME = "Courses";

  Courses({this.id, this.weekDay,this.courseId, this.courseVenue,this.courseTime,this.courseType});
  // Convert a course into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'weekDay': weekDay,
      'courseId': courseId,
      'courseVenue': courseVenue,
      'courseTime':courseTime,
      'courseType':courseType,
    };
  }

}
