import 'measurement_type.dart';
import 'measurement_unit.dart';
import 'package:intl/intl.dart';

class Measurement {
  int id;
  String date;
  num value;
  MeasurementType type;
  MeasurementUnit unit;
  num mobility;

  Measurement({
    required this.id,
    required this.date,
    required this.value,
    required this.type,
    required this.unit,
    this.mobility=0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'measurement_type_id': type.id,
      'unit_id': unit.id,
      'value': value,
      'created_at': date
    };
  }

  Measurement.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        date = map['date'],
        value = map['value'],
        type = MeasurementType(id: map['mt_id'], name: map['mt_name']),
        unit = MeasurementUnit(id: map['mu_id'], name: map['mu_name']),
        mobility = map['mobility'];


  @override
  String toString() {
    return 'Measurement{id: $id, date: $date, value: $value, type: ${type.toString()} unit: ${unit.toString()}, mobility: $mobility }';
  }
}

class HeightMeasurement extends Measurement {
  HeightMeasurement(id, date, value, type, unit, mobility)
      : super(
            id: id,
            date: date,
            value: value,
            type: type,
            unit: unit,
            mobility: mobility);


  HeightMeasurement.fromMap(Map<String, dynamic> map)
      : super.fromMap(map);
}

class WeightMeasurement extends Measurement {
  WeightMeasurement(id, date, value, type, unit, mobility)
      : super(
            id: id,
            date: date,
            value: value,
            type: type,
            unit: unit,
            mobility: mobility);

  WeightMeasurement.fromMap(Map<String, dynamic> map)
      : super.fromMap(map);
}


class BmiMeasurement extends Measurement {
  BmiMeasurement(id, date, value, type, unit, mobility)
      : super(
      id: id,
      date: date,
      value: value,
      type: type,
      unit: unit,
      mobility: mobility);

  BmiMeasurement.fromMap(Map<String, dynamic> map)
      : super.fromMap(map);
}

class FormData{
  final String date;
  final double value;
  final int typeId;
  final int unitId;
  FormData({required this.date, required this.value,required this.typeId,required this.unitId});

  FormData.fromMap(Map<String, dynamic> map):date=map['date'],value=map['value'],typeId=map['typeId'],unitId=map['unitId'];

  Map<String, dynamic> toMap(){
    return {
      'measurement_type_id': typeId,
      'unit_id': unitId,
      'value': double.parse((value).toStringAsFixed(1)),
      'created_at': DateFormat("yyyy-MM-dd").format(DateTime.now())
    };
  }
}
