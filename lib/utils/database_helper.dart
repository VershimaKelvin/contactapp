
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  DatabaseHelper.privateConstructor();
  DatabaseHelper instance= DatabaseHelper.privateConstructor();

  static const  databaseName = 'myDb.db';
  static const dbVersion=1;
  static const tableName= 'myTable';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnAge = 'Age';

  Database? _database;

  Future<Database> get database async{
    if(_database==null){
      return _database!;
    }
    else {
      return await initializeDatabase();
    }
  }

  Future<Database> initializeDatabase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,databaseName);
    return await openDatabase(path,version: dbVersion,onCreate:onCreate);
  }

  onCreate(Database db, int version){
    db.execute(
      '''
      CREATE TABLE $tableName(
      $columnId PRIMARY KEY NOT NULL
      $columnName TEXT NOT NULL
      $columnAge INT NOT NULL
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

  Future<int> update(Map<String,dynamic> row)async{
    Database database = await instance.database;
    return await database.update(tableName, row);
  }

  // Future<int> delete(int id)async{
  //
  // }

}