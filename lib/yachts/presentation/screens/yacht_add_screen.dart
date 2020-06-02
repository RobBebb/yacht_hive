import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';
import 'package:yacht_hive/yachts/presentation/widgets/toast.dart';

class YachtAddScreen extends StatefulWidget {
  static const routeName = 'yachtaddscreen';

  @override
  _YachtAddScreenState createState() => _YachtAddScreenState();
}

class _YachtAddScreenState extends State<YachtAddScreen> {
  String name;
  int imo;
  double length;

  void _addYacht(context) {
    if (name == null) {
      toastWidget("Give entry a name");
      return;
    }
    if (name.length < 2) {
      toastWidget("Get a longer name");
      return;
    }
    Provider.of<YachtData>(context, listen: false).addYacht(
      yacht: Yacht(
        name: name,
        imo: imo ?? 0,
        length: length ?? 0,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 16.0,
        title: Text(
          'Add Yacht',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            iconSize: 24.0,
            color: Colors.blue,
            tooltip: 'Save',
            onPressed: () {
              _addYacht(context);
            },
          ),
        ],
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
              onChanged: (v) {
                setState(
                  () {
                    name = v;
                  },
                );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                hintText: 'IMO',
              ),
              onChanged: (v) {
                setState(
                  () {
                    imo = int.parse(v);
                  },
                );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Length',
              ),
              onChanged: (v) {
                setState(
                  () {
                    length = double.parse(v);
                  },
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
