import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './yachts/presentation/screens/yachts_screen.dart';
import './yachts/presentation/screens/edit_yacht_screen.dart';
import './yachts/domain/yacht.dart';

const String yachtBoxName = 'yacht';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Yacht>(YachtAdapter());
  await Hive.openBox<Yacht>(yachtBoxName);
  runApp(
    MyApp(),
  );
  // await Hive.close();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sea Days',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          primaryColorLight: Colors.amber[100],
          primaryColorDark: Colors.amber[700],
          accentColor: Colors.lightGreenAccent,
          fontFamily: 'SourceSansPro',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        home: YachtsScreen(),
        routes: {
          YachtsScreen.routeName: (ctx) => YachtsScreen(),
          EditYachtScreen.routeName: (ctx) => EditYachtScreen(),
        },
      );
  }
}
