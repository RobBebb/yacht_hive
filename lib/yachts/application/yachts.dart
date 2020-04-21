import 'package:flutter/material.dart';
import '../infrastructure/yacht_repository_in_memory.dart';
import '../domain/yacht.dart';

class Yachts with ChangeNotifier {

  List<Yacht> _yachts = [];


  List<Yacht> get yachts {
    return [..._yachts];
  }

  Yacht fetchYachtByName(String name) {
    return _yachts.firstWhere((yacht) => yacht.name == name);
  }

  Future<void> fetchAndSetYachts() async {
    YachtRepositoryInline yachtRepository  = YachtRepositoryInline();
    try {
    final List<Yacht> loadedYachts = await yachtRepository.selectYachts();
    _yachts = loadedYachts;
    notifyListeners();

    } catch (error) {
      print(error);
    }
  }
}