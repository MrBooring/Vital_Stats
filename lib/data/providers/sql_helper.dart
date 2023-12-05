import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
      CREATE TABLE User (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        mobile TEXT UNIQUE,
        password TEXT
      )
    ''');

    await database.execute('''
      CREATE TABLE IF NOT EXISTS FoodTracker (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        foodName TEXT,
        unit TEXT,
        date TEXT,
        time TEXT
      )
    ''');

    await database.execute('''
      CREATE TABLE IF NOT EXISTS WorkoutTracker (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        workoutName TEXT,
        wtime TEXT,
        date TEXT,
        time TEXT
      )
    ''');

    await database.execute('''
      CREATE TABLE IF NOT EXISTS WaterTracker (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        waterGlass INTEGER,
        date TEXT,
        time TEXT
      )
    ''');

    await database.execute('''
      CREATE TABLE IF NOT EXISTS SleepTracker (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        sleepTime TEXT,
        wakeUpTime TEXT,
        date TEXT,
        time TEXT
      )
    ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('urbanfit_db', version: 1,
        onCreate: (db, version) async {
      await createTables(db);
    });
  }

  static Future<int> createUser(
      String name, String email, String mobile, String password) async {
    final sql.Database db = await SQLHelper.db();

    final user = {
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
    };

    final existingUser = await db.query(
      'User',
      where: 'mobile = ?',
      whereArgs: [mobile],
    );

    if (existingUser.isNotEmpty) {
      return 0;
    }

    return db.insert('User', user,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<Map<String, dynamic>> fetchUserByEmailAndPassword(
      String email, String password) async {
    final sql.Database db = await SQLHelper.db();

    final List<Map<String, dynamic>> users = await db.query(
      'User',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (users.isNotEmpty) {
      final user = users.first;
      if (user['password'] == password) {
        return user; // Password matches, return the user data
      } else {
        return {'error': 'Incorrect password'}; // Incorrect password
      }
    }

    return {'error': 'User not found'}; // User not found
  }

  static Future<Map<String, dynamic>> fetchUserById(int userId) async {
    final sql.Database db = await SQLHelper.db();

    final List<Map<String, dynamic>> users = await db.query(
      'User',
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );

    if (users.isNotEmpty) {
      return users.first;
    }

    return {};
  }

  /// ****************** Foodtracker Crud ********************* ///

  static Future<int> addFoodTracker(int userId, String foodName, String unit,
      String date, String time) async {
    final sql.Database db = await SQLHelper.db();

    final tracker = {
      'userId': userId,
      'foodName': foodName,
      'unit': unit,
      'date': date,
      'time': time,
    };

    return db.insert('FoodTracker', tracker,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchFoodTrackers(
      int userId) async {
    final sql.Database db = await SQLHelper.db();

    return db.query('FoodTracker', where: 'userId = ?', whereArgs: [userId]);
  }

  static Future<int> updateFoodTracker(int trackerId, String foodName,
      String unit, String date, String time) async {
    final sql.Database db = await SQLHelper.db();

    final tracker = {
      'foodName': foodName,
      'unit': unit,
      'date': date,
      'time': time,
    };

    return db.update('FoodTracker', tracker,
        where: 'id = ?', whereArgs: [trackerId]);
  }

  static Future<int> deleteFoodTracker(int trackerId) async {
    final sql.Database db = await SQLHelper.db();

    return db.delete('FoodTracker', where: 'id = ?', whereArgs: [trackerId]);
  }

  /// ****************** WorkOuttracker Crud ********************* ///

  static Future<int> addWorkoutTracker(int userId, String workoutName,
      String wtime, String time, String date) async {
    final sql.Database db = await SQLHelper.db();

    final tracker = {
      'userId': userId,
      'workoutName': workoutName,
      'wtime': wtime,
      'time': time,
      'date': date,
    };

    return db.insert('WorkoutTracker', tracker,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchWorkoutTrackers(
      int userId) async {
    final sql.Database db = await SQLHelper.db();

    return db.query('WorkoutTracker', where: 'userId = ?', whereArgs: [userId]);
  }

  static Future<int> updateWorkoutTracker(int trackerId, String workoutName,
      String wtime, String time, String date) async {
    final sql.Database db = await SQLHelper.db();

    final tracker = {
      'workoutName': workoutName,
      'wtime': wtime,
      'time': time,
      'date': date,
    };

    return db.update('WorkoutTracker', tracker,
        where: 'id = ?', whereArgs: [trackerId]);
  }

  static Future<int> deleteWorkoutTracker(int trackerId) async {
    final sql.Database db = await SQLHelper.db();

    return db.delete('WorkoutTracker', where: 'id = ?', whereArgs: [trackerId]);
  }

  /// ****************** Watertracker Crud ********************* ///

  static Future<int> addWaterTracker(
      int userId, int waterGlass, String date, String time) async {
    final sql.Database db = await SQLHelper.db();

    final tracker = {
      'userId': userId,
      'waterGlass': waterGlass,
      'date': date,
      'time': time,
    };

    return db.insert('WaterTracker', tracker,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchWaterTrackers(
      int userId) async {
    final sql.Database db = await SQLHelper.db();

    return db.query('WaterTracker', where: 'userId = ?', whereArgs: [userId]);
  }

  static Future<int> updateWaterTracker(
      int trackerId, int waterGlass, String date, String time) async {
    final sql.Database db = await SQLHelper.db();

    final tracker = {
      'waterGlass': waterGlass,
      'date': date,
      'time': time,
    };

    return db.update('WaterTracker', tracker,
        where: 'id = ?', whereArgs: [trackerId]);
  }

  static Future<int> deleteWaterTracker(int trackerId) async {
    final sql.Database db = await SQLHelper.db();

    return db.delete('WaterTracker', where: 'id = ?', whereArgs: [trackerId]);
  }

  /// ****************** Sleeptracker Crud ********************* ///

  static Future<int> addSleepTracker(int userId, String sleepTime,
      String wakeUpTime, String date, String time) async {
    final sql.Database db = await SQLHelper.db();

    final tracker = {
      'userId': userId,
      'sleepTime': sleepTime,
      'wakeUpTime': wakeUpTime,
      'date': date,
      'time': time,
    };

    return db.insert('SleepTracker', tracker,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchSleepTrackers(
      int userId) async {
    final sql.Database db = await SQLHelper.db();

    return db.query('SleepTracker', where: 'userId = ?', whereArgs: [userId]);
  }

  static Future<int> updateSleepTracker(int trackerId, String sleepTime,
      String wakeUpTime, String date, String time) async {
    final sql.Database db = await SQLHelper.db();

    final tracker = {
      'sleepTime': sleepTime,
      'wakeUpTime': wakeUpTime,
      'date': date,
      'time': time,
    };

    return db.update('SleepTracker', tracker,
        where: 'id = ?', whereArgs: [trackerId]);
  }

  static Future<int> deleteSleepTracker(int trackerId) async {
    final sql.Database db = await SQLHelper.db();

    return db.delete('SleepTracker', where: 'id = ?', whereArgs: [trackerId]);
  }
}
