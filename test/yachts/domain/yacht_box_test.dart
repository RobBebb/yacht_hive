import 'package:hive/hive.dart';
import 'package:test/test.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_box.dart';

const _yachtBoxName = 'yachtBox';

void main() async {
  setUpAll(() async {
    Hive.init('bbb');
    Hive.registerAdapter<Yacht>(YachtAdapter());
    await Hive.openBox<Yacht>(
      _yachtBoxName,
    );
  });

  tearDownAll(() async {
    var box = await Hive.openBox<Yacht>(
      _yachtBoxName,
    );
    box.deleteFromDisk();
    Hive.close();
  });

  group('Yacht Box...', () {
    test('Add and get a yacht', () async {
      final Yacht newYacht = Yacht(
        id: '10',
        name: 'Aaa',
        imo: 1111111,
        length: 111,
        buildDate: DateTime(2000, 1, 1),
      );
      YachtBox().addYacht(yacht: newYacht);
      Yacht addedYacht = await YachtBox().getYacht(
        key: newYacht.id,
      );
      expect(addedYacht.id, '10');
      expect(addedYacht.name, 'Aaa');
      expect(addedYacht.imo, 1111111);
      expect(addedYacht.length, 111);
      expect(addedYacht.buildDate, DateTime(2000, 1, 1));
    });

    test('Get a non-existant yacht', () async {
      Yacht gotYacht = await YachtBox().getYacht(
        key: '13',
      );
      expect(gotYacht, null);
    });


    test('Edit a yacht', () async {
      final Yacht newYacht = Yacht(
        id: '11',
        name: 'Ccc',
        imo: 3333333,
        length: 333.3,
        buildDate: DateTime(2011, 1, 1),
      );

      YachtBox().addYacht(
        yacht: newYacht,
      );

      final Yacht editYacht = Yacht(
        id: '11',
        name: 'Ffff',
        imo: 4444444,
        length: 44.4,
        buildDate: DateTime(2004, 4, 4),
      );

      YachtBox().editYacht(
        key: editYacht.id,
        yacht: editYacht,
      );
      Yacht editedYacht = await YachtBox().getYacht(
        key: newYacht.id,
      );
      expect(editedYacht.id, '11');
      expect(editedYacht.name, 'Ffff');
      expect(editedYacht.imo, 4444444);
      expect(editedYacht.length, 44.4);
      expect(editedYacht.buildDate, DateTime(2004, 4, 4));
    });

    test('Delete a yacht', () async {
      final Yacht newYacht = Yacht(
        id: '33',
        name: 'Gggg',
        imo: 5555555,
        length: 55.5,
        buildDate: DateTime(2005, 5, 5),
      );

      YachtBox().addYacht(yacht: newYacht);
      Yacht addedYacht = await YachtBox().getYacht(
        key: newYacht.id,
      );
      expect(addedYacht.id, '33');

      YachtBox().deleteYacht(key: newYacht.id);
      Yacht deletedYacht = await YachtBox().getYacht(
        key: newYacht.id,
      );
      expect(deletedYacht, null);
    });
    test('Get yachts', () async {
      Yacht newYacht = Yacht(
        id: '77',
        name: 'Kllll',
        imo: 7777777,
        length: 77.7,
        buildDate: DateTime(2007, 7, 7),
      );
      YachtBox().addYacht(yacht: newYacht);

      newYacht = Yacht(
        id: '88',
        name: 'Bbbb',
        imo: 8888888,
        length: 88.8,
        buildDate: DateTime(2008, 8, 8),
      );
      YachtBox().addYacht(yacht: newYacht);

      List<Yacht> yachts = await YachtBox().getYachts();

      var index = yachts.indexWhere((yacht) => yacht.name == 'Kllll');
      expect(yachts[index].id, '77');
      expect(yachts[index].key, '77');
      expect(yachts[index].name, 'Kllll');
      expect(yachts[index].imo, 7777777);
      expect(yachts[index].length, 77.7);
      expect(yachts[index].buildDate, DateTime(2007, 7, 7));

      index = yachts.indexWhere((yacht) => yacht.name == 'Bbbb');
      expect(yachts[index].id, '88');
      expect(yachts[index].key, '88');
      expect(yachts[index].name, 'Bbbb');
      expect(yachts[index].imo, 8888888);
      expect(yachts[index].length, 88.8);
      expect(yachts[index].buildDate, DateTime(2008, 8, 8));
    });
  });
}
