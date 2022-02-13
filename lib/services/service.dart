import '../repositories/database.dart';
import '../models/all_models.dart';
import 'package:flutter/foundation.dart';

class AppService with ChangeNotifier {
  final DBSingleton _databaseService = DBSingleton();

  Future<HeightMeasurement?> getLatestHeight() async {
    final List latestHeights = await _databaseService.getLatestHeight();
    if (latestHeights.isEmpty) {
      return null;
    }

    if (latestHeights.length == 1) {
      final myMap = latestHeights[0];
      Map<String, Object?> map = Map<String, Object?>.from(myMap);
      map['mobility'] = 0;
      return HeightMeasurement.fromMap(map);
    }

    if (latestHeights.length == 2) {
      final myMap = latestHeights[0];
      final mobility = myMap['value'] - latestHeights[1]['value'];

      // get the first record
      Map<String, Object?> map = Map<String, Object?>.from(myMap);
      map['mobility'] = mobility.floor();
      return HeightMeasurement.fromMap(map);
    }

    if (latestHeights.length > 2) {
      throw Exception('More than two rows where returned');
    }
  }

  Future<BmiMeasurement?> getLatestBmi() async {
    final List latestBmis = await _databaseService.getLatestBmi();
    if (latestBmis.isEmpty) {
      return null;
    }
    if (latestBmis.length == 1) {
      final myMap = latestBmis[0];
      Map<String, Object?> map = Map<String, Object?>.from(myMap);
      map['mobility'] = 0;
      return BmiMeasurement.fromMap(map);
    }

    if (latestBmis.length == 2) {
      final myMap = latestBmis[0];
      final mobility = myMap['value'] - latestBmis[1]['value'];

      // get the first record
      Map<String, Object?> map = Map<String, Object?>.from(myMap);
      map['mobility'] = mobility.floor();
      return BmiMeasurement.fromMap(map);
    }

    if (latestBmis.length > 2) {
      throw Exception('More than two rows where returned');
    }
  }

  Future<WeightMeasurement?> getLatestWeight() async {
    final List latestWeights = await _databaseService.getLatestWeight();
    if (latestWeights.isEmpty) {
      return null;
    }
    if (latestWeights.length == 1) {
      final myMap = latestWeights[0];
      Map<String, Object?> map = Map<String, Object?>.from(myMap);
      map['mobility'] = 0;
      return WeightMeasurement.fromMap(map);
    }

    if (latestWeights.length == 2) {
      final myMap = latestWeights[0];
      final mobility = myMap['value'] - latestWeights[1]['value'];

      // get the first record
      Map<String, Object?> map = Map<String, Object?>.from(myMap);
      map['mobility'] = mobility.floor();
      return WeightMeasurement.fromMap(map);
    }

    if (latestWeights.length > 2) {
      throw Exception('More than two rows where returned');
    }
  }

  Future<Measurement?> get measurement async {
    return await getLatestWeight();
  }

  // Future<void> saveWeight(Measurement measurement) async {
  //   // todo:: Continue from here
  //   await _databaseService.insertMeasurement(measurement.toMap());
  // }

  Future<List<MeasurementType>> getAllWeightUnits() async {
    final List weights = await _databaseService.getWeightUnits();
    return List.generate(weights.length, (i) {
      return MeasurementType.fromMap(weights[i]);
    });
  }

  Future<List<MeasurementType>> getAllHeightUnits() async {
    final List heights = await _databaseService.getHeightUnits();
    return List.generate(heights.length, (i) {
      return MeasurementType.fromMap(heights[i]);
    });
  }

  Future<void> saveMeasurements(List<FormData> measurements) async {
    List<FormData> _allMeasurements = measurements;
    if (measurements.length == 2) {
      final double _weight = measurements[0].value;
      final double _height = measurements[1].value;
      final _bmi = _calculateBmi(_height, _weight);
      final FormData data = FormData.fromMap(
          {'date': '2022-2-11', 'typeId': 3, 'unitId': 3, 'value': _bmi});
      _allMeasurements.add(data);
    } else {
      if (measurements[0].typeId == 1) {
        final HeightMeasurement? _heightMeasurement = await getLatestHeight();
        if (_heightMeasurement != null) {
          final double _weight = measurements[0].value;
          final double _height = _heightMeasurement.value.toDouble();
          final _bmi = _calculateBmi(_height, _weight);
          final FormData data = FormData.fromMap(
              {'date': '2022-2-11', 'typeId': 3, 'unitId': 3, 'value': _bmi});
          _allMeasurements.add(data);
        }
      } else if (measurements[0].typeId == 2) {
        final WeightMeasurement? _weightMeasurement = await getLatestWeight();
        if (_weightMeasurement != null) {
          final double _weight = _weightMeasurement.value.toDouble();
          final double _height = measurements[0].value;
          final _bmi = _calculateBmi(_height, _weight);
          final FormData data = FormData.fromMap(
              {'date': '2022-2-11', 'typeId': 3, 'unitId': 3, 'value': _bmi});
          _allMeasurements.add(data);
        }
      }
    }

    await _databaseService.insertMeasurement(measurements);
    notifyListeners();
  }

  double _calculateBmi(double height, double weight) {
    return weight / (height * height * 0.01 * 0.01);
  }

  Future<List<Measurement>> getThisMonthWeights() async {
    final weights = await _databaseService.getThisMonthWeights();
    final data = List.generate(weights.length, (i) {
      Map<String, Object?> map = Map<String, Object?>.from(weights[i]);
      map['mobility'] = 0;
      return Measurement.fromMap(map);
    });

    return data;
  }

  Future<List<Measurement>> getMinMaxWeight() async {
    final weights = await _databaseService.getMinMaxWeight();
    final data = List.generate(weights.length, (i) {
      Map<String, Object?> map = Map<String, Object?>.from(weights[i]);
      map['mobility'] = 0;
      return Measurement.fromMap(map);
    });

    if (data.length == 1) {
      data.add(data[0]);
    }
    // print(data);
    return data;
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    final db = await _databaseService.database;
    await db.close();
    super.dispose();
  }
}
