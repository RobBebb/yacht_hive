import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../widgets/yacht_card.dart';
import './edit_yacht_screen.dart';
import '../../domain/yacht.dart';

const String yachtBoxName = 'yacht';

class YachtsScreen extends StatefulWidget {
  static const routeName = 'yachtscreen';

  @override
  _YachtsScreenState createState() => _YachtsScreenState();
}

class _YachtsScreenState extends State<YachtsScreen> {
  // @override
  // void initState() {
  //   Provider.of<Yachts>(context, listen: false).fetchAndSetYachts();
  //   super.initState();
  // }

  // _refreshYachts(BuildContext context) {
  //   Provider.of<Yachts>(context, listen: false).yachts;

  // }

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
                  fontSize: Theme.of(context).textTheme.headline6.fontSize),
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
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Yacht>(yachtBoxName).listenable(),
        builder: (context, Box<Yacht> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('No Yachts'),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Yacht currentYacht = box.getAt(index);
              return YachtCard(currentYacht, index);
              
              // Card(
              //   clipBehavior: Clip.antiAlias,
              //   child: InkWell(
              //     onLongPress: () {/* ... */},
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           SizedBox(
              //             height: 5,
              //           ),
              //           Text(currentYacht.name),
              //           SizedBox(
              //             height: 5,
              //           ),
              //           Text("Index: $index"),
              //           SizedBox(
              //             height: 5,
              //           ),
              //           Text("imo: ${currentYacht.imo}"),
              //           SizedBox(
              //             height: 5,
              //           ),
              //           Text("key: ${currentYacht.key}"),
              //         ],
              //       ),
              //     ),
              //   ),
              // );
            },
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditYachtScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
