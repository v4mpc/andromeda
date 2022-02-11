import 'repository.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBSingleton {
  static final DBSingleton _dbSingleton = DBSingleton._internal();

  factory DBSingleton() => _dbSingleton;

  DBSingleton._internal();

  static const _dbName = 'andromeda.db';
  static const _dbVersion = 1;

  static DBSingleton get instance => _dbSingleton;
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

  static Database? _database;

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
      'CREATE TABLE settings(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, value TEXT)',
    );
    //create seeders

    await db.execute(
      'CREATE TABLE units(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT)',
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


    await db.insert(
      'units',
      {'id': 3, 'name': 'Bmi'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.execute(
      'CREATE TABLE measurement_types(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT)',
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

    await db.insert(
      'measurement_types',
      {'id': 3, 'name': 'BMI'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.execute(
      "CREATE TABLE measurements(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,measurement_type_id INTEGER, unit_id INTEGER,value REAL,created_at TEXT,"
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

    await db.insert(
      'measurements',
      {
        'id': 2,
        'measurement_type_id': 1,
        'unit_id': 1,
        'value': 70,
        'created_at': '2022-01-23'
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );


    await db.insert(
      'measurements',
      {
        'id': 3,
        'measurement_type_id': 1,
        'unit_id': 1,
        'value': 89.1,
        'created_at': '2022-01-23'
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );


    await db.insert(
      'measurements',
      {
        'id': 4,
        'measurement_type_id': 2,
        'unit_id': 2,
        'value': 170.2,
        'created_at': '2022-01-23'
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );


    await db.insert(
      'measurements',
      {
        'id': 5,
        'measurement_type_id': 3,
        'unit_id': 3,
        'value': 2,
        'created_at': '2022-01-23'
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );



  }

  Future measurements(query) async {
    final db = await database;
    return await db.rawQuery(query);
  }

  Future getLatestWeight() {
    const query = "WHERE MT.name='WEIGHT'"
        "ORDER BY M.id DESC LIMIT 2";
    return measurements('$baseMeasurementQuery $query');
  }

  Future getLatestHeight() {
    const query = "WHERE MT.name='HEIGHT'"
        "ORDER BY M.id DESC LIMIT 2";
    return measurements('$baseMeasurementQuery $query');
  }

  Future getLatestBmi() {
    const query = "WHERE MT.name='BMI'"
        "ORDER BY M.id DESC LIMIT 2";
    return measurements('$baseMeasurementQuery $query');
  }

  Future<void> insertMeasurement(data) async {
    final db = await database;
    await db.insert(
      'measurements',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future getWeightUnits() async {
    final db = await database;
    return db.query('units');
  }

  Future getHeightUnits() async {
    final db = await database;
    return db.query('measurements_types');
  }
}
