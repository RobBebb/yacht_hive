import 'dart:math';

import '../infrastructure/yacht_repository.dart';
import '../domain/yacht.dart';

// This implementation of repository has a problem because the class keeps
// getting reinstantiated so the in memory list keeps dissappearing.
class YachtRepositoryInMemory implements YachtRepository {
  List<Yacht> _yachts = [
    Yacht(
      id: 1,
      name: 'C2',
      imo: 1009833,
      length: 88.5,
    ),
    // Yacht(
    //   id: 2,
    //   name: 'Diamond',
    //   imo: 7654321,
    //   length: 65,
    // ),
    // Yacht(
    //   id: 3,
    //   name: 'La Familia',
    //   imo: 1012660,
    //   length: 55,
    // ),
    // Yacht(
    //   id: 4,
    //   name: 'Lady Lara',
    //   imo: 1012311,
    //   length: 91,
    // ),
    // Yacht(
    //   id: 5,
    //   name: 'Griff',
    //   imo: 9033880,
    //   length: 42,
    // ),
    // Yacht(
    //   id: 6,
    //   name: 'Her Honor',
    //   imo: 8992039,
    //   length: 44.85,
    // ),
    // Yacht(
    //   id: 7,
    //   name: 'Serenity J',
    //   imo: 1012385,
    //   length: 55,
    // ),
    // Yacht(
    //   id: 8,
    //   name: 'Skat',
    //   imo: 1007287,
    //   length: 70.7,
    // ),
    // Yacht(
    //   id: 8,
    //   name: 'SYZYGY 818',
    //   imo: 9798258,
    //   length: 77.25,
    // ),
  ];

  @override
  Future<List<Yacht>> selectYachts() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        print('RobBebb selectYachts');
        return _yachts;
      },
    );
  }

  Future<int> insertYacht(Yacht yacht) {
    print('RobBebb insertYacht');

    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();
        var newId = random.nextInt(1000);

        // make sure the id is unique
        while (
            _yachts.indexWhere((existingYacht) => existingYacht.id == newId) !=
                -1) {
          newId = random.nextInt(1000);
        }
        var newYacht = Yacht(
          id: newId,
          name: yacht.name,
          imo: yacht.imo,
          length: yacht.length,
        );
        print('RobBebb insertYacht. Name: ${newYacht.name}');
        _yachts.add(newYacht);
        return newYacht.id;
      },
    );
  }

  Future<Yacht> selectYacht(int id) {
    print('RobBebb selectYacht');

    return Future.delayed(
      Duration(seconds: 1),
      () {
        // var selectedYacht = _yachts.firstWhere((yacht) => yacht.id == id);
        // return selectedYacht;
        return;
      },
    );
  }

  Future<void> updateYacht(Yacht yacht) {
    print('RobBebb updateYacht');

    return Future.delayed(
      Duration(seconds: 1),
      () {
        // final yachtIndex = _yachts.indexWhere((yacht) => yacht.id == id);
        // var updatedYacht = Yacht(
        //   id: yacht.id,
        //   name: yacht.name,
        //   imo: yacht.imo,
        //   length: yacht.length,
        // );
        // _yachts[yachtIndex] = updatedYacht;
        //_yachts.removeAt(index);
        return;
      },
    );
  }

  Future<void> deleteYacht(int id) {
    print('RobBebb deleteYacht');

    return Future.delayed(
      Duration(seconds: 1),
      () {
        // final yachtIndex = _yachts.indexWhere((yacht) => yacht.id == id);
        // print('RobBebb deleteYacht. id: ${id}');
        // print('RobBebb deleteYacht. index: $yachtIndex');
        // _yachts.removeAt(yachtIndex);
        return;
      },
    );
  }
}
