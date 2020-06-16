import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';
import 'package:yacht_hive/yachts/presentation/widgets/yacht_card.dart';

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
    testWidgets('Check literals', (WidgetTester tester) async {
      // Build the provider
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

      // Build the widget to test
      await tester.pumpWidget(
        YachtCard(yachtIndex: 0,)
      );

      // await tester.pumpAndSettle();
      await tester.pump();

      final textTypeFinder = find.byType(Card);
      expect(textTypeFinder, findsWidgets);

      final imoFinder = find.text('IMO: 111');
      expect(imoFinder, findsOneWidget);

    });
    
  });
}
