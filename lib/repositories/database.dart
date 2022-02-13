import 'dart:async';
import '../models/all_models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

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
    await db.transaction((txn) async {
      await txn.rawQuery(
          'CREATE TABLE settings(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, value TEXT)');
      await txn.rawQuery(
          'CREATE TABLE measurement_types(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT)');
      await txn.rawQuery(
          'CREATE TABLE units(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT)');
      await txn.rawQuery(
          "CREATE TABLE measurements(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,measurement_type_id INTEGER, unit_id INTEGER,value REAL,created_at TEXT,"
          "FOREIGN KEY (measurement_type_id) REFERENCES measurement_types (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
          "FOREIGN KEY (unit_id) REFERENCES units (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
          ")");
      await txn.insert('units', {'id': 1, 'name': 'Kg'});
      await txn.insert('units', {'id': 2, 'name': 'Cm'});
      await txn.insert('units', {'id': 3, 'name': 'Bmi'});
      await txn.insert('measurement_types', {'id': 1, 'name': 'WEIGHT'});
      await txn.insert('measurement_types', {'id': 2, 'name': 'HEIGHT'});
      await txn.insert('measurement_types', {'id': 3, 'name': 'BMI'});
      await txn.insert('measurements', {
        'id': 1,
        'measurement_type_id': 1,
        'unit_id': 1,
        'value': 80,
        'created_at': '2022-01-2'
      });

      await txn.insert('measurements', {
        'id': 2,
        'measurement_type_id': 1,
        'unit_id': 1,
        'value': 70,
        'created_at': '2022-02-03'
      });

      await txn.insert('measurements', {
        'id': 3,
        'measurement_type_id': 1,
        'unit_id': 1,
        'value': 89.1,
        'created_at': '2022-02-05'
      });

      await txn.insert('measurements', {
        'id': 4,
        'measurement_type_id': 2,
        'unit_id': 2,
        'value': 170.2,
        'created_at': '2022-02-16'
      });

      await txn.insert('measurements', {
        'id': 5,
        'measurement_type_id': 3,
        'unit_id': 3,
        'value': 2,
        'created_at': '2022-02-23'
      });
    });
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

  //TODO::add ability to reset all measurments; or the latest height or weight or height.

  Future<void> insertMeasurement(List<FormData> measurements) async {
    final db = await database;
    Batch batch = db.batch();
    for (var m in measurements) {
      batch.rawDelete(
          'DELETE FROM measurements WHERE measurement_type_id = ? AND unit_id = ? AND created_at = ?',
          [m.typeId, m.unitId, m.toMap()['created_at']]);
      batch.insert('measurements', m.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future getWeightUnits() async {
    final db = await database;
    return db.query('units');
  }

  Future getHeightUnits() async {
    final db = await database;
    return db.query('measurements_types');
  }

  Future<void> initialDatabaseSeed() async {}

  Future getThisMonthWeights() async {
    final db = await database;
    final DateTime now = DateTime.now();
    final String year = DateFormat('yyyy').format(now);
    final String month = DateFormat('MM').format(now);
    const String query =
        "WHERE strftime('%m', M.created_at) = ? AND strftime('%Y', M.created_at) = ? AND M.measurement_type_id = ? ORDER by M.created_at ASC LIMIT 31";
    return await db
        .rawQuery('$baseMeasurementQuery $query', [month, year, '1']);
  }

  Future getMinMaxWeight() async {
    final db = await database;
    final DateTime now = DateTime.now();
    final String year = DateFormat('yyyy').format(now);
    final String month = DateFormat('MM').format(now);
    const String maxQuery =
        "SELECT MAX(value) from measurements WHERE strftime('%m', created_at) = ? AND strftime('%Y', created_at) = ? AND measurement_type_id = ?";
    const String minQuery =
        "SELECT MIN(value) from measurements WHERE strftime('%m', created_at) = ? AND strftime('%Y', created_at) = ? AND measurement_type_id = ?";
    const String subQuery =
        "WHERE M.value IN (($maxQuery),($minQuery)) ORDER by M.value DESC";
    return await db.rawQuery(
        '$baseMeasurementQuery $subQuery', [month, year, 1, month, year, 1]);
  }
}
