import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';

const _yachtBoxName = 'yachtBox';

void main() async {
  final _providerKey = GlobalKey();
  final _childKey = GlobalKey();

  setUpAll(() async {
    Hive.init('yyy');
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

  group('Yacht Data...', () {
    testWidgets('Add and get a yacht', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (c) => YachtData(),
          child: Container(key: _childKey),
        ),
      );
      // await pumpWidget;
      // tester.pump;
      final yachtData =
          Provider.of<YachtData>(_childKey.currentContext, listen: false);

      Yacht newYacht = Yacht(
        id: 'a',
        name: 'Aaa',
        imo: 111,
        length: 11.1,
        buildDate: DateTime(2000, 1, 1),
      );
      yachtData.addYacht(yacht: newYacht);
      Yacht gotYacht = yachtData.getYacht(index: 0);
      expect(gotYacht.name, 'Aaa');
    });
    testWidgets('Get a yacht by name', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (c) => YachtData(),
          child: Container(key: _childKey),
        ),
      );
      // await pumpWidget;
      // tester.pump;
      final yachtData =
          Provider.of<YachtData>(_childKey.currentContext, listen: false);

      Yacht newYacht = Yacht(
        name: 'Bbb',
        imo: 222,
        length: 22.2,
        buildDate: DateTime(2002, 2, 2),
      );
      yachtData.addYacht(yacht: newYacht);
      Yacht gotYacht = yachtData.getYachtName(name: newYacht.name);
      expect(gotYacht.name, 'Bbb');
    });

    testWidgets('Edit a yacht', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (c) => YachtData(),
          child: Container(key: _childKey),
        ),
      );
      // await pumpWidget;
      // tester.pump;
      final yachtData =
          Provider.of<YachtData>(_childKey.currentContext, listen: false);

      Yacht addYacht = Yacht(
        name: 'Ccc',
        imo: 333,
        length: 33.3,
        buildDate: DateTime(2003, 3, 3),
      );
      yachtData.addYacht(yacht: addYacht);

      Yacht addedYacht = yachtData.getYachtName(name: addYacht.name);

      final Yacht editYacht = Yacht(
        name: 'Ddddd',
        imo: 555,
        length: 55.5,
        buildDate: DateTime(2005, 5, 5),
      );

      yachtData.editYacht(
        yacht: editYacht,
        id: addedYacht.id,
      );

      Yacht editedYacht = yachtData.getYachtName(name: editYacht.name);
      expect(editedYacht.name, 'Ddddd');
      Yacht originalYacht = yachtData.getYachtName(name: addYacht.name);
      expect(originalYacht, null);
    });

    testWidgets('Count yachts', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (c) => YachtData(),
          child: Container(key: _childKey),
        ),
      );
      // await pumpWidget;
      // tester.pump;
      final yachtData =
          Provider.of<YachtData>(_childKey.currentContext, listen: false);

      Yacht addYacht = Yacht(
        name: 'Ccc',
        imo: 333,
        length: 33.3,
        buildDate: DateTime(2003, 3, 3),
      );
      yachtData.addYacht(yacht: addYacht);

      addYacht = Yacht(
        name: 'Ssss',
        imo: 444,
        length: 44.4,
        buildDate: DateTime(2004, 4, 4),
      );
      yachtData.addYacht(yacht: addYacht);

      expect(yachtData.yachtCount, 2);
    });

    testWidgets('Set and Get active yacht', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          key: _providerKey,
          create: (c) => YachtData(),
          child: Container(key: _childKey),
        ),
      );
      // await pumpWidget;
      // tester.pump;
      final yachtData =
          Provider.of<YachtData>(_childKey.currentContext, listen: false);

      Yacht addYacht = Yacht(
        name: 'Ccc',
        imo: 333,
        length: 33.3,
        buildDate: DateTime(2003, 3, 3),
      );
      yachtData.addYacht(yacht: addYacht);

      addYacht = Yacht(
        name: 'Ssss',
        imo: 444,
        length: 44.4,
        buildDate: DateTime(2004, 4, 4),
      );
      yachtData.addYacht(yacht: addYacht);

      Yacht firstYacht = yachtData.getYachtName(name: 'Ccc');

      yachtData.setActiveYacht(id: firstYacht.id);

      Yacht gotYacht = yachtData.getActiveYacht();

      expect(gotYacht.name, 'Ccc');
    });
    
  });
}
