
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  DatabaseHelper.privateConstructor();
  static DatabaseHelper instance= DatabaseHelper.privateConstructor();

  static const  databaseName = 'myDatabase.db';
  static const dbVersion=1;
  static const tableName= 'myTable';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnAge = 'number';

  Database? _database;

  Future<Database> get database async{
    if(_database!=null){
      return _database!;
    }
      return await initializeDatabase();
  }

  Future<Database> initializeDatabase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,databaseName);
    return await openDatabase(path,version: dbVersion,onCreate:onCreate);
  }

  onCreate(Database db, int version)async{
   await db.execute(
        '''
      CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnAge TEXT NOT NULL
      )
      '''
    );
  }

  Future<int> insert(Map<String, dynamic> row)async{
    Database database = await instance.database;
    return await database.insert(tableName, row);
  }

  Future<List<Map<String,dynamic>>> query()async{
    Database database = await instance.database;
    return await database.query(tableName);
  }


  //update database
  Future<int> update(Map<String,dynamic> row)async{
    Database database = await instance.database;
    return await database.update(tableName, row,where: 'id=?',whereArgs:[2] );
  }

  // Future<int> delete(int id)async{
  //
  // }

}