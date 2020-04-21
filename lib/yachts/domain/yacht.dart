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
}
