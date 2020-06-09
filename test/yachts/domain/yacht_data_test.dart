import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:provider/provider.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';

void main() async {

  setUp(() {
  Hive.init('xxx');
  Hive.registerAdapter<Yacht>(YachtAdapter());
  });

  group('Yacht Data...', () {
    testWidgets('Add and get a yacht', (WidgetTester tester) async {
      final _providerKey = GlobalKey();
      final _childKey = GlobalKey();

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

      Yacht newYacht = Yacht(name: 'Aaa', imo: 111, length: 11.1);
      yachtData.addYacht(yacht: newYacht);
      Yacht gotYacht = yachtData.getYacht(0);
      expect(gotYacht.name, 'Aaa');
    });
  });
}
