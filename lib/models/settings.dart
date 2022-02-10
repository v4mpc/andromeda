import 'measurement_unit.dart';


class Settings{
  String username;
  bool darkMode;
  MeasurementUnit globalWeightUnit;
  MeasurementUnit globalHeightUnit;
  Settings({required this.username,this.darkMode=false,required this.globalHeightUnit,required this.globalWeightUnit});

}