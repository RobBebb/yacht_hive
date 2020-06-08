import 'package:hive/hive.dart';
import 'package:yacht_hive/core/logs/log.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';

class YachtBox {
  static const _yachtBoxName = 'yachtBox';

  Future<List<Yacht>> getYachts() async {
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    return box.values.toList();
  }

  void addYacht({Yacht yacht}) async{
    print('Adding yacht: ${yacht.name}');
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    box.add(yacht);
  }

  void deleteYacht(key) async {
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    await box.delete(key);

    Log.i('Deleted yacht with key ${key.toString()}');
  }

  void editYacht({Yacht yacht, int yachtKey}) async{
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    await box.put(yachtKey, yacht);

    Log.i('Edited yacht ${yacht.name}');
  }

}
