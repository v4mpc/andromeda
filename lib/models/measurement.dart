import 'measurement_type.dart';
import 'measurement_unit.dart';

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
    required this.mobility,
  });

  Map<String, dynamic> toMap() {
    // return {
    //   'id': id,
    //   'date': date,
    //   'value': value,
    //   'type': type.toMap(),
    //   'unit': unit.toMap()
    // };
    return {
      'id': id,
      'measurement_type_id': type.id,
      'unit_id': unit.id,
      'value': value,
      'created_at': date
    };
  }

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      id: map['id'],
      date: map['date'],
      value: map['value'],
      type: MeasurementType(id: map['mt_id'], name: map['mt_name']),
      unit: MeasurementUnit(id: map['mu_id'], name: map['mu_name']),
      mobility: map['mobility'],
    );
  }

  @override
  String toString() {
    return 'Measurement{id: $id, date: $date, value: $value, type: ${type.toString()} unit: ${unit.toString()}, mobility: $mobility }';
  }
}
