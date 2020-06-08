import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:provider/provider.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';

void main() async {
  Hive.init('xxx');
  Hive.registerAdapter<Yacht>(YachtAdapter());

  testWidgets('', (WidgetTester tester) async {
    final _providerKey = GlobalKey();

    final _childKey = GlobalKey();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        key: _providerKey,
        create: (c) => YachtData(),
        child: Container(key: _childKey),
      ),
    );

    Yacht newYacht = Yacht(name: 'Aaa', imo: 111, length: 11.1);
    final yachtData1 =
        Provider.of<YachtData>(_childKey.currentContext, listen: false);

    yachtData1.addYacht(yacht: newYacht);

    // await tester.pump();

    Yacht gotYacht = yachtData1.getYacht(0);

    expect(gotYacht.name, 'Aaa');

  });
}
