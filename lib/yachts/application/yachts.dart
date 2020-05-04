import 'package:flutter/material.dart';
import 'package:yacht_provider/yachts/infrastructure/yacht_repository_sqlite.dart';
// import '../infrastructure/yacht_repository_in_memory.dart';
import '../domain/yacht.dart';

class Yachts with ChangeNotifier {
  List<Yacht> _yachts = [];

  List<Yacht> get yachts {
    return [..._yachts];
  }

  Yacht findYachtById(int id) {
    return _yachts.firstWhere((yacht) => yacht.id == id);
  }

  Yacht fetchYachtByName(String name) {
    print('RobBebb fetchYachtByName');

    return _yachts.firstWhere((yacht) => yacht.name == name);
  }

  Future<void> fetchAndSetYachts() async {
    print('RobBebb fetchAndSetYachts');

    // YachtRepositoryInMemory yachtRepository = YachtRepositoryInMemory();
    YachtRepositorySqlite yachtRepository = YachtRepositorySqlite();
    try {
      final List<Yacht> loadedYachts = await yachtRepository.selectYachts();
      if (loadedYachts == null) {
        return;
      }
      _yachts = loadedYachts;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addYacht(Yacht yacht) async {
    print('RobBebb addYacht');

    // YachtRepositoryInMemory yachtRepository = YachtRepositoryInMemory();
        YachtRepositorySqlite yachtRepository = YachtRepositorySqlite();

    final newYachtId = await yachtRepository.insertYacht(yacht);
    print('RobBebb addYacht. Id: $newYachtId');
    Yacht newYacht = Yacht(
      id: newYachtId,
      name: yacht.name,
      imo: yacht.imo,
      length: yacht.length,
    );
    _yachts.add(newYacht);
    print('RobBebb addYacht. _yachts ${[..._yachts][0].name}');
    notifyListeners();
  }

  Future<void> maintainYacht(int id, Yacht maintainedYacht) async {
    print('RobBebb maintainYacht');

    // YachtRepositoryInMemory yachtRepository = YachtRepositoryInMemory();
        YachtRepositorySqlite yachtRepository = YachtRepositorySqlite();

    final yachtIndex = _yachts.indexWhere((yacht) => yacht.id == id);
    await yachtRepository.updateYacht(maintainedYacht);
    _yachts[yachtIndex] = maintainedYacht;
    notifyListeners();
  }

  Future<void> removeYacht(int id) async {
    print('RobBebb removeYacht. id: $id');

    // YachtRepositoryInMemory yachtRepository = YachtRepositoryInMemory();
        YachtRepositorySqlite yachtRepository = YachtRepositorySqlite();

    final yachtIndex = _yachts.indexWhere((yacht) => yacht.id == id);
    await yachtRepository.deleteYacht(id);
    _yachts.removeAt(yachtIndex);
    notifyListeners();
  }
}
