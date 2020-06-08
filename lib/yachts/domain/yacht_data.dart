import 'package:flutter/material.dart';
import 'package:yacht_hive/core/logs/log.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_box.dart';

class YachtData extends ChangeNotifier {

  List<Yacht> _yachts = [];

  Yacht _activeYacht;

  void getYachts() async {
    _yachts = await YachtBox().getYachts();
    notifyListeners();
  }

  Yacht getYacht(index) {
    print('Getting yacht');
    return _yachts[index];
  }

  Yacht getYachtName({String name}) {
    var index = _yachts.indexWhere((yacht) => yacht.name == name);
    print('index: $index');
    return getYacht(index);
  }

  void addYacht({Yacht yacht}) async{
    print('Adding yacht: ${yacht.name}');
    YachtBox().addYacht(yacht: yacht);
    _yachts.add(yacht);
    print('First yacht: ${_yachts[0].toString()}');
    notifyListeners();
  }

  void deleteYacht(key) async {
    YachtBox().deleteYacht(key);
    _yachts.removeWhere((yacht) => yacht.key == key);

    Log.i('Deleted yacht with key ${key.toString()}');

    notifyListeners();
  }

  void editYacht({Yacht yacht, int yachtKey}) async{
    YachtBox().editYacht(yacht: yacht, yachtKey: yachtKey);
    _yachts.removeWhere((yacht) => yacht.key == yachtKey);
    _yachts.add(yacht);

    _activeYacht = yacht;

    Log.i('Edited yacht ${yacht.name}');

    notifyListeners();
  }

  void setActiveYacht(key) async {
    _activeYacht = _yachts.firstWhere((yacht) => yacht.key == key);

    notifyListeners();
  }

  Yacht getActiveYacht() {
    return _activeYacht;
  }

  int get yachtCount {
    return _yachts.length;
  }

}
