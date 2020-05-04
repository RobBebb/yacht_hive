import 'package:flutter/foundation.dart';

class Yacht {
  final int id;
  final String name;
  final int imo;
  final double length;

  Yacht({
    @required this.id,
    @required this.name,
    @required this.imo,
    this.length,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imo': imo,
      'length': length,
    };
  }

  static Yacht fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Yacht(
      id: map['id'],
      name: map['name'],
      imo: map['imo'],
      length: map['length'],
    );
  }

  @override
  String toString() {
    return 'Yacht(id: $id, name: $name, imo: $imo, length: $length)';
  }
}
