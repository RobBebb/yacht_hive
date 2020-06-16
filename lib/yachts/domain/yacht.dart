import 'package:hive/hive.dart';

part 'yacht.g.dart';

@HiveType(typeId: 0)
class Yacht extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int imo;

  @HiveField(3)
  final double length;

  @HiveField(4)
  final DateTime buildDate;

  Yacht({
    this.id,
    this.name,
    this.imo,
    this.length,
    this.buildDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imo': imo,
      'length': length,
      'buildDate': buildDate,
    };
  }

  static Yacht fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Yacht(
      id: map['id'],
      name: map['name'],
      imo: map['imo'],
      length: map['length'],
      buildDate: map['buildDate'],
    );
  }

  @override
  String toString() {
    return 'Yacht(id: $id, name: $name, imo: $imo, length: $length, buildDate: ${buildDate?.toIso8601String()})';
  }
}
