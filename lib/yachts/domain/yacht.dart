import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'yacht.g.dart';

@HiveType(typeId: 0)
class Yacht extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int imo;

  @HiveField(2)
  final double length;

  Yacht({
    @required this.name,
    @required this.imo,
    this.length,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imo': imo,
      'length': length,
    };
  }

  static Yacht fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Yacht(
      name: map['name'],
      imo: map['imo'],
      length: map['length'],
    );
  }

  @override
  String toString() {
    return 'Yacht(name: $name, imo: $imo, length: $length)';
  }
}
