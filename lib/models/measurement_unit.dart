


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

  @override
  String toString() {
    return 'Unit{id: $id, name: $name}';
  }
}