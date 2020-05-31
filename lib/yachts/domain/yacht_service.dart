import 'package:hive/hive.dart';

import './yacht.dart';

const String yachtBoxName = 'yacht';

abstract class IYachtService {
  //init();
  addYacht(Yacht yacht);
  updateYacht(int index, Yacht yacht);
  deleteYacht(int index);
  List<Yacht> loadYachts();
}

class YachtService implements IYachtService {
  Box<Yacht> yachtBox = Hive.box<Yacht>(yachtBoxName);

  @override
  addYacht(Yacht yacht) async {
    await yachtBox.add(yacht);
    print('added $yacht');
  }

  @override
  updateYacht(int index, Yacht yacht) async {
    await yachtBox.putAt(index, yacht);
    print('updated $yacht at $index');
  }

  @override
  deleteYacht(int index) {
    yachtBox.deleteAt(index);
    print('removed yacht at $index');
  }

  @override
  List<Yacht> loadYachts() {
    return yachtBox.values.toList();
  }
}
