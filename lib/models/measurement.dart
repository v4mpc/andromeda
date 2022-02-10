import 'measurement_type.dart';
import 'measurement_unit.dart';

class Measurement{
  String date;
  double value;
  MeasurementType type;
  MeasurementUnit unit;
  Measurement({required this.date,required this.value,required this.type,required this.unit });
}