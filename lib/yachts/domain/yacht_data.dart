import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yacht_hive/core/logs/log.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';

class YachtData extends ChangeNotifier {
  static const _yachtBoxName = 'yachtBox';

  List<Yacht> _yachts = [];

  Yacht _activeYacht;

  void getYachts() async {
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    _yachts = box.values.toList();
    notifyListeners();
  }

  Yacht getYacht(index) {
    return _yachts[index];
  }

  void addYacht({Yacht yacht}) async{
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    await box.add(yacht);
    _yachts = box.values.toList();
    notifyListeners();
  }

  void deleteYacht(key) async {
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    await box.delete(key);
    _yachts = box.values.toList();

    Log.i('Deleted yacht with key ${key.toString()}');

    notifyListeners();
  }
  void editYacht({Yacht yacht, int yachtKey}) async{
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    await box.put(yachtKey, yacht);
    _yachts = box.values.toList();

    _activeYacht = box.get(yachtKey);

    Log.i('Edited yacht ${yacht.name}');

    notifyListeners();
  }

  void setActiveYacht(key) async {
    var box = await Hive.openBox<Yacht>(_yachtBoxName);
    _activeYacht = box.get(key);

    notifyListeners();
  }

  Yacht getActiveYacht() {
    return _activeYacht;
  }

  int get yachtCount {
    return _yachts.length;
  }

}
