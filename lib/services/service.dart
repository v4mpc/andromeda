import '../repositories/database.dart';
import '../models/all_models.dart';
import 'package:flutter/foundation.dart';

class WeightService with ChangeNotifier{
  final DBSingleton _databaseService = DBSingleton();

  Future<Measurement?> getLatestWeight() async {
    final List latestWeights = await _databaseService.getLatestWeight();
    if (latestWeights.isEmpty) {
      return null;
    }
    if (latestWeights.length == 1) {
      final myMap = latestWeights[0];
      Map<String, Object?> map = Map<String, Object?>.from(myMap);
      map['mobility'] = 0;
      return Measurement.fromMap(map);
    }

    if (latestWeights.length == 2) {
      final myMap = latestWeights[0];
      final mobility = myMap['value'] - latestWeights[1]['value'];

      // get the first record
      Map<String, Object?> map = Map<String, Object?>.from(myMap);
      map['mobility'] = mobility;
      return Measurement.fromMap(map);
    }

    if (latestWeights.length > 2) {
      throw Exception('More than two rows where returned');
    }
  }

  Future<Measurement?> get measurement async{
    return await getLatestWeight();
  }



  Future<void> saveWeight(Measurement measurement) async {
    // todo:: Continue from here
    await _databaseService.insertMeasurement(measurement.toMap());
  }

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
}
