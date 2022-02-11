


class MeasurementUnit{
  String name;
  int id;

  MeasurementUnit({required this.id,required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory MeasurementUnit.fromMap(Map<String,dynamic> map){
    return MeasurementUnit(
        id: map['id'],
        name: map['id']
    );
  }

  @override
  String toString() {
    return 'Unit{id: $id, name: $name}';
  }
}