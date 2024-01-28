import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../view/screen/inner_screen/Archive.dart';
import '../view/screen/inner_screen/Done.dart';
import '../view/screen/inner_screen/Task.dart';



abstract class AppStates {}

class AppIniState extends AppStates {}

class AppBottomNavBar extends AppStates {}

//Sqlite
class AppGetFromDataBase extends AppStates {}

class AppUPDateDataBase extends AppStates {}

class AppInsertToDataBase extends AppStates {}

class AppDeleteFromDataBase extends AppStates {}

class AppChangeDrawer extends AppStates {}


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIniState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> pages = [
    const Task(),
    const Done(),
    const Archive(),
  ];

  List<String> title = [
    "Task",
    "Done",
    "Archive",
  ];

  List<Icon> appbarIcons = [
    const Icon(
      Icons.note_alt_sharp,
    ),
    const Icon(
      Icons.download_done_sharp,
    ),
    const Icon(
      Icons.delete_forever,
    ),
  ];

  void getCurrentIndex(int index) {
    currentIndex = index;
    emit(AppBottomNavBar());
  }


  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    if (globalKey.currentState != null) {
      globalKey.currentState!.openDrawer();
    } else {
      print("Error");
    }
  }


  String? image;

  void getData({
    required String image,
  }) {
     this.image = image;
    openDrawer();
    emit(AppChangeDrawer());
  }



  late Database database;

  Future<void> createDataBase() async {
    database = await openDatabase(
      'myNote.bd',
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,time TEXT,status TEXT,image TEXT)',
        );
      },
      onOpen: (db) {
        getFromDatabase(db);
      },
    );
    emit(AppGetFromDataBase());
  }

  Future<void> insertToDatabase({
    required String title,
    required String time,
    required String image,
  }) async {
    try {
      await database.transaction((txn) async {
        await txn.rawInsert(
          'INSERT INTO tasks(title,time,status,image) VALUES(?, ?, "new", ?)',
          [title, time, image],
        );
        emit(AppInsertToDataBase());
        getFromDatabase(database);
      });
    } catch (error) {
      print('Error inserting to database: $error');
    }
  }

  List<Map<String, dynamic>> taskListNew = [];
  List<Map<String, dynamic>> taskListDone = [];
  List<Map<String, dynamic>> taskListRemove = [];

  Future<void> getFromDatabase(database) async {
    taskListNew.clear();
    taskListDone.clear();
    taskListRemove.clear();

    List<Map<String, dynamic>> value =
        await database.rawQuery('SELECT * FROM tasks');
    emit(AppGetFromDataBase());

    value.forEach((e) {
      if (e['status'] == 'new') {
        taskListNew.add(e);
      } else if (e['status'] == 'done') {
        taskListDone.add(e);
      } else {
        taskListRemove.add(e);
      }
    });
  }

  Future<void> updateData({
    required String status,
    required int id
  }) async {
    try {
      await database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id],
      );
      getFromDatabase(database);
      emit(AppUPDateDataBase());
    } catch (error) {
      print('Error updating data: $error');
    }
  }

  Future<void> deleteData({required int id}) async {
    try {
      await database.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [id],
      );
      getFromDatabase(database);
      emit(AppDeleteFromDataBase());
    } catch (error) {
      print('Error deleting data: $error');
    }
  }

}
