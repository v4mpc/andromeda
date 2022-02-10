import 'package:andromeda/models/all_models.dart';
import 'package:andromeda/models/measurement.dart';

import '../repository.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  String _dbName = 'andromeda';
  int _dbVersion = 1;
  Database? _database;

  String baseMeasurementQuery = "SELECT "
      "M.id,"
      "M.created_at as date,"
      "M.value,"
      "MT.id as mt_id,"
      "MT.name as mt_name,"
      "MU.id as mu_id,"
      "MU.name as mu_name "
      "FROM "
      "measurements as M "
      "INNER JOIN measurement_types as MT ON M.measurement_type_id=MT.id "
      "INNER JOIN units as MU ON M.unit_id=MU.id";

  Future<Database> get database async => _database ??= await _init();

  Future<Database> _init() async {
    final dbPath = join(await getDatabasesPath(), _dbName);
    if (await databaseExists(dbPath)) {
      await deleteDatabase(dbPath);
    }

    return await openDatabase(dbPath,
        version: _dbVersion, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE settings(id INTEGER PRIMARY KEY, name TEXT, value TEXT)',
    );
    //create seeders

    await db.execute(
      'CREATE TABLE units(id INTEGER PRIMARY KEY, name TEXT)',
    );

    await db.insert(
      'units',
      {'id': 1, 'name': 'Kg'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      'units',
      {'id': 2, 'name': 'Cm'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.execute(
      'CREATE TABLE measurement_types(id INTEGER PRIMARY KEY, name TEXT)',
    );

    await db.insert(
      'measurement_types',
      {'id': 1, 'name': 'WEIGHT'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      'measurement_types',
      {'id': 2, 'name': 'HEIGHT'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.execute(
      "CREATE TABLE measurements(id INTEGER PRIMARY KEY,measurement_type_id INTEGER, unit_id INTEGER,value REAL,created_at TEXT,"
      "FOREIGN KEY (measurement_type_id) REFERENCES measurement_types (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
      "FOREIGN KEY (unit_id) REFERENCES units (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
      ")",
    );

    await db.insert(
      'measurements',
      {
        'id': 1,
        'measurement_type_id': 1,
        'unit_id': 1,
        'value': 80,
        'created_at': '2022-01-23'
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteMeasurementUnit(int id) async {
    final db = await database;
    await db.delete(
      'measurement_units',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteMeasurementType(int id) async {
    final db = await database;
    await db.delete(
      'measurement_types',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> getAllUnits() async {
    final db = await database;
    await db.query(
      'measurement_units',
    );
  }

  Future<void> getAllMeasurementTypes() async {
    final db = await database;
    await db.query(
      'measurement_types',
    );
  }

  // Future<List<Measurement>> measurements(query) async {
  //   final db = await database;
  //
  //   final List<Map<String, dynamic>> maps =
  //       await db.rawQuery(query);
  //   // Convert the List<Map<String, dynamic> into a List<Dog>.
  //   return List.generate(maps.length, (i) {
  //     return Measurement(
  //         id: maps[i]['id'],
  //         date: maps[i]['date'],
  //         value: maps[i]['value'],
  //         type: MeasurementType(id: maps[i]['mt_id'], name: maps[i]['mt_name']),
  //         unit:
  //             MeasurementUnit(id: maps[i]['mu_id'], name: maps[i]['mu_name']));
  //   });
  // }


  // Future<List<Measurement>> getLatestWeight(){
  //   const query="WHERE MT.name='WEIGHT'"
  //       "ORDER BY M.id DESC LIMIT 2";
  //   return measurements('$baseMeasurementQuery $query');
  // }
  // Future<List<Measurement>> getLatestHeight(){
  //   const query="WHERE MT.name='HEIGHT'"
  //       "ORDER BY M.id DESC LIMIT 2";
  //   return measurements('$baseMeasurementQuery $query');
  // }


}
