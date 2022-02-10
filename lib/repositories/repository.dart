import 'package:flutter/foundation.dart';


abstract class Repository {
  void insertMeasurementUnit();
  List getAllMeasurementUnits();
  void deleteMeasurementUnit();


  void insertMeasurementType();
  List getAllMeasurementTypes();
  void deleteMeasurementType();
}