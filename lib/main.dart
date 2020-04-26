import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacht_provider/yachts/presentation/screens/edit_yacht_screen.dart';

import './yachts/application/yachts.dart';
import './yachts/presentation/screens/yachts_screen.dart';
import './yachts/presentation/screens/edit_yacht_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Yachts(),
      child: MaterialApp(
        title: 'Sea Days',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          primaryColorLight: Colors.amber[100],
          primaryColorDark: Colors.amber[700],
          accentColor: Colors.lightGreenAccent,
          fontFamily: 'SourceSansPro',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
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
      ),
    );
  }
}
