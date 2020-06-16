import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

  Yacht getYacht({index}) {
    return index == null ? null : _yachts[index];
  }

  Yacht getYachtName({String name}) {
    if (name == null) {
      return null;
    } else {
      var index = _yachts.indexWhere((yacht) => yacht.name == name);
      return index == -1 ? null : getYacht(index: index);
    }
  }

  void addYacht({Yacht yacht}) async {
    yacht.id = Uuid().v4();
    YachtBox().addYacht(yacht: yacht);
    _yachts.add(yacht);
    notifyListeners();
  }

  void deleteYacht({String id}) async {
    YachtBox().deleteYacht(key: id);
    _yachts.removeWhere((yacht) => yacht.id == id);

    // Log.i('Deleted yacht with key $id');

    notifyListeners();
  }

  void editYacht({Yacht yacht, String id}) async {
    YachtBox().editYacht(yacht: yacht, key: id);
    _yachts.removeWhere((yacht) => yacht.id == id);
    _yachts.add(yacht);

    _activeYacht = yacht;

    // Log.i('Edited yacht ${yacht.name}');

    notifyListeners();
  }

  void setActiveYacht({String id}) async {
    _activeYacht = _yachts.firstWhere((yacht) => yacht.id == id);

    notifyListeners();
  }

  Yacht getActiveYacht() {
    return _activeYacht;
  }

  int get yachtCount {
    return _yachts.length;
  }
}
