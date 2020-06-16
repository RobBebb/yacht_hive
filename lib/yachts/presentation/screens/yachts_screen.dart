import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';

import 'package:yacht_hive/yachts/presentation/widgets/yacht_card.dart';
import 'package:yacht_hive/yachts/presentation/screens/edit_yacht_screen.dart';

const String yachtBoxName = 'yacht';

class YachtsScreen extends StatefulWidget {
  static const routeName = 'yachtscreen';

  @override
  _YachtsScreenState createState() => _YachtsScreenState();
}

class _YachtsScreenState extends State<YachtsScreen> {
  @override
  void initState() {
    Provider.of<YachtData>(context, listen: false).getYachts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: <Widget>[
            Image.asset('assets/images/historic-ship-48.png'),
            SizedBox(
              width: 20,
            ),
            Text(
              'Yachts',
              key: Key('title'),
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline6.fontSize),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            key: Key('add_IconButton'),
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditYachtScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          // if (Provider.of<YachtData>(context).yachtCount == 0) {
          //   toastWidget("There are no yachts. Please add one.");
          // }
          return YachtCard(
            yachtIndex: index,
          );
        },
        itemCount: Provider.of<YachtData>(context).yachtCount,
        padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 4.0),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            key: Key('fab'),
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, EditYachtScreen.routeName);
            },
          );
        },
      ),
    );
  }
}
