class Events {
  final int id;
  final String events;
  final String time;
  static const String TABLENAME = "events";

  Events({this.id, this.events, this.time});

  Map<String, dynamic> toMap() {
    return {'id': id, 'events': events, 'time': time};
  }
}