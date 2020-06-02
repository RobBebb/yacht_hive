import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';
import 'package:yacht_hive/yachts/presentation/screens/yacht_add_screen.dart';
import 'package:yacht_hive/yachts/presentation/widgets/yacht_list.dart';

class YachtListScreen extends StatelessWidget {
  static const routeName = 'yachtlistscreen';

  @override
  Widget build(BuildContext context) {
    Provider.of<YachtData>(context, listen: false).getYachts();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 16.0,
        title: Text(
          'Yachts',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: YachtList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent,
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, YachtAddScreen.routeName);
        },),
    );
  }
}
