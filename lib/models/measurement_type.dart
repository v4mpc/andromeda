class MeasurementType {
  int id;
  String name;

  MeasurementType({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'MeasurementType{id: $id, name: $name}';
  }

  factory MeasurementType.fromMap(Map<String,dynamic> map){
    return MeasurementType(
      id: map['id'],
      name: map['id']
    );
  }
}
