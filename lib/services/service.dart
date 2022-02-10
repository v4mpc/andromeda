import '../repositories/database.dart';
import '../models/all_models.dart';

class WeightService {
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

  Future<void> saveWeight(Measurement measurement) async {
    // todo:: COntinue from here
    await _databaseService.insertMeasurement(measurement.toMap());
  }
}
