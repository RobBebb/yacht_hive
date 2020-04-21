import 'dart:math';

import '../infrastructure/yacht_repository.dart';
import '../domain/yacht.dart';

class YachtRepositoryInline implements YachtRepository {
  List<Yacht> _yachts = [
    Yacht(
      id: 1,
      name: 'C2',
      imo: 1009833,
      length: 88.5,
    ),
    Yacht(
      id: 2,
      name: 'Diamond',
      imo: 7654321,
      length: 65,
    ),
    Yacht(
      id: 3,
      name: 'La Familia',
      imo: 1012660,
      length: 55,
    ),
    Yacht(
      id: 4,
      name: 'Lady Lara',
      imo: 1012311,
      length: 91,
    ),
    Yacht(
      id: 5,
      name: 'Griff',
      imo: 9033880,
      length: 42,
    ),
    Yacht(
      id: 6,
      name: 'Her Honor',
      imo: 8992039,
      length: 44.85,
    ),
    Yacht(
      id: 7,
      name: 'Serenity J',
      imo: 1012385,
      length: 55,
    ),
    Yacht(
      id: 8,
      name: 'Skat',
      imo: 1007287,
      length: 70.7,
    ),
    Yacht(
      id: 8,
      name: 'SYZYGY 818',
      imo: 9798258,
      length: 77.25,
    ),
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
        var selectedYacht = _yachts.firstWhere((yacht) => yacht.id == id);
        return selectedYacht;
      },
    );
  }

  Future<void> updateYacht(int id, Yacht yacht) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final yachtIndex = _yachts.indexWhere((yacht) => yacht.id == id);
        var updatedYacht = Yacht(
          id: yacht.id,
          name: yacht.name,
          imo: yacht.imo,
          length: yacht.length,
        );
        _yachts[yachtIndex] = updatedYacht;
        //_yachts.removeAt(index);
        return;
      },
    );
  }

  Future<void> deleteYacht(int id) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final yachtIndex = _yachts.indexWhere((yacht) => yacht.id == id);
        _yachts.removeAt(yachtIndex);
        return;
      },
    );
  }
}
