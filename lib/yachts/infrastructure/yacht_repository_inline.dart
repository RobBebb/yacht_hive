import 'dart:math';

import 'package:yacht_provider/yachts/application/yachts.dart';

import '../infrastructure/yacht_repository.dart';
import '../domain/yacht.dart';

class YachtRepositoryInline implements YachtRepository {
  List<Yacht> _yachts = [
    Yacht(
      id: 1,
      name: 'C2',
      imo: 1234567,
      length: 85.5,
    ),
    Yacht(
      id: 1,
      name: 'Diamond',
      imo: 7654321,
      length: 65,
    )
  ];

  @override
  Future<List<Yacht>> selectYachts() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return _yachts;
      },
    );
  }

  Future<Yacht> insertYacht(Yacht yacht) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();
        var newYacht = Yacht(
          id: random.nextInt(100),
          name: yacht.name,
          imo: yacht.imo,
          length: yacht.length,
        );
        _yachts.add(newYacht);
        return newYacht;
      },
    );
  }

    Future<Yacht> selectYacht(int id) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        var selectedYacht = _yachts.firstWhere((yacht) => yacht.id == id)
        return selectedYacht;
      },
    );
  }

    Future<Yacht> updateYacht(Yacht yacht) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        var updatedYacht = Yacht(
          id: yacht.id,
          name: yacht.name,
          imo: yacht.imo,
          length: yacht.length,
        );
        _yachts.removeAt(index);
        return newYacht;
      },
    );
  }


}
