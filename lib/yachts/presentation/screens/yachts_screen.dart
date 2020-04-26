import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/yachts.dart';
import '../widgets/yacht_card.dart';
import './edit_yacht_screen.dart';

class YachtsScreen extends StatefulWidget {
  static const routeName = 'yachtscreen';

  @override
  _YachtsScreenState createState() => _YachtsScreenState();
}

class _YachtsScreenState extends State<YachtsScreen> {
  @override
  void initState() {
    Provider.of<Yachts>(context, listen: false).fetchAndSetYachts();
    super.initState();
  }

  _refreshYachts(BuildContext context) {
    Provider.of<Yachts>(context, listen: false).yachts;
    
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
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.title.fontSize),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditYachtScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshYachts(context),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapShot.error != null) {
              return Center(
                child: Text('An error occurred.'),
              );
            } else {
              return Consumer<Yachts>(
                builder: (ctx, yachtData, child) => ListView.builder(
                  itemCount: yachtData.yachts.length,
                  itemBuilder: (ctx, i) => YachtCard(yachtData.yachts[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
