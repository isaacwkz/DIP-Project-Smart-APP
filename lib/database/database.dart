import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dip_taskplanner/database/model/Courses.dart';
import 'package:dip_taskplanner/database/model/Todo.dart';
import 'package:dip_taskplanner/database/model/Events.dart';

class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();

  static const databaseName = 'db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, content TEXT)");
          await db.execute(
              "CREATE TABLE Courses(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, weekDay TEXT, courseId TEXT , courseVenue TEXT, courseTime TEXT, courseType TEXT)");
          await db.execute(
              "CREATE TABLE events(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, events TEXT, time TEXT)");
        });
  }

  insertTodo(Todo todo) async {
    final db = await database;
    var res = await db.insert(Todo.TABLENAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Todo>> retrieveTodos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Todo.TABLENAME);

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });
  }

  updateTodo(Todo todo) async {
    final db = await database;

    await db.update(Todo.TABLENAME, todo.toMap(),
        where: 'id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteTodo(int id) async {
    var db = await database;
    db.delete(Todo.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }

  insertCourses(Courses course) async {
    final db = await database;
    var res = await db.insert(Courses.TABLENAME, course.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(course);
    print('test');
    return res;
  }

  Future<List<Courses>> retrieveCourses() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Courses.TABLENAME);

    return List.generate(maps.length, (i) {
      return Courses(
        id: maps[i]['id'],
        weekDay: maps[i]['weekDay'],
        courseId: maps[i]['courseId'],
        courseVenue: maps[i]['courseVenue'],
        courseTime: maps[i]['courseTime'],
        courseType: maps[i]['courseType'],
      );
    });
  }

  updateCourse(Courses course) async {
    final db = await database;

    await db.update(Courses.TABLENAME, course.toMap(),
        where: 'id = ?',
        whereArgs: [course.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteCourse(int id) async {
    var db = await database;
    db.delete(Courses.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }


  insertEvents(Events events) async {
    final db = await database;
    var res = await db.insert(Events.TABLENAME, events.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(events);
    print('test');
    return res;
  }

  Future<List<Events>> retrieveEvents() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Events.TABLENAME);

    return List.generate(maps.length, (i) {
      return Events(
        id: maps[i]['id'],
        events: maps[i]['events'],
        time: maps[i]['time'],
      );
    });
  }

  updateEvents(Events events) async {
    final db = await database;

    await db.update(Events.TABLENAME, events.toMap(),
        where: 'id = ?',
        whereArgs: [events.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteEvents(int id) async {
    var db = await database;
    db.delete(Events.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }
}

