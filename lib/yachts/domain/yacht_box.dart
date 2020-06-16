import 'package:hive/hive.dart';

// import 'package:yacht_hive/core/logs/log.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';

class YachtBox {
  static const _yachtBoxName = 'yachtBox';

  Future<List<Yacht>> getYachts() async {
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    return box.values.toList();
  }

    Future<Yacht> getYacht({key}) async {
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    return box.get(key);
  }


  void addYacht({Yacht yacht}) async {
    // print('Adding yacht: ${yacht.name}');
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    box.put(yacht.id, yacht);

    // Log.i('Added yacht with key ${yacht.toString()}');
  }

  void deleteYacht({String key}) async {
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    await box.delete(key);

    // Log.i('Deleted yacht with key $key');
  }

  void editYacht({Yacht yacht, String key}) async {
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    await box.put(key, yacht);

    // Log.i('Edited yacht ${yacht.name}');
  }
}
