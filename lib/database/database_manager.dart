import 'dart:io';

import 'package:covid19_ui/models/users.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'database_enum.dart';

class DatabaseManager {

  static DatabaseManager _databaseManager;
  static Database _database;

  DatabaseManager._instance();

  factory DatabaseManager() {
    if (_databaseManager == null) {
      _databaseManager = DatabaseManager._instance();
    }

    return _databaseManager;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'covido.db';

    var covidoDatabase = await openDatabase(path, version: 2, onCreate: _createDb);
    return covidoDatabase;
  }

  void _createDb(Database database, int newVersion) async {

    await database.execute(
        'create table users_table ('
            '	id INTEGER not null'
            ' primary key autoincrement,'
            ' first_name TEXT not null,'
            ' last_name TEXT not null,'
            ' birthday TEXT not null,'
            ' place_of_birth TEXT not null,'
            ' adress TEXT not null,'
            ' town TEXT not null,'
            ' zipcode INTEGER not null,'
            ' is_favorite INTEGER not null'
        ' );'
    );
  }

  // Fetch Operation: Get all users objects from database
  Future<List<Map<String, dynamic>>> getUsersMapList() async {
    Database db = await this.database;

    var result = await db.query('users_table', orderBy: 'id');
    return result;
  }

  // Insert Operation: Insert a User object to database
  Future<int> insertUser(User user) async {
    Database database = await this.database;
    var result = await database.insert('users_table', user.toMap());
    return result;
  }

  // Update Operation: Update a User object and save it to database
  Future<int> updateUser(User user) async {
    var database = await this.database;
    var result = await database.update('users_table', user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
    return result;
  }

  // Delete Operation: Delete a User object from database
  Future<int> deleteUser(int id) async {
    var database = await this.database;
    int result = await database.rawDelete('DELETE FROM users_table WHERE id = $id;');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database database = await this.database;
    List<Map<String, dynamic>> count = await database.rawQuery('SELECT COUNT (*) from users_table');
    int result = Sqflite.firstIntValue(count);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'User List' [ List<User> ]
  Future<List<User>> getUserList() async {
    var noteMapList = await getUsersMapList(); // Get 'Map List' from database
    int count = noteMapList.length; // Count the number of map entries in database table

    List<User> noteList = List<User>();
    // For loop to create a 'User List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(User.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

}
