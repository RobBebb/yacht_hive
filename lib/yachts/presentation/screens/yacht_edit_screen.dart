import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';
import 'package:yacht_hive/yachts/presentation/widgets/toast.dart';

class YachtEditScreen extends StatefulWidget {
  final Yacht currentYacht;

  YachtEditScreen({@required this.currentYacht});

  @override
  _YachtEditScreenState createState() => _YachtEditScreenState();
}

class _YachtEditScreenState extends State<YachtEditScreen> {
  String newName;
  int newImo;
  double newLength;

  void _editYacht(context) {
    if (newName == null) {
      toastWidget("Give entry a name");
      return;
    }
    if (newName.length < 2) {
      toastWidget("Get a longer name");
      return;
    }
    Provider.of<YachtData>(context, listen: false).editYacht(
        yacht: Yacht(
          name: newName,
          imo: newImo ?? 0,
          length: newLength ?? 0,
        ),
        yachtKey: widget.currentYacht.key);
    Navigator.pop(context);
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imoController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.currentYacht.name;
    newName = widget.currentYacht.name;

    _imoController.text = widget.currentYacht.imo.toString();
    newImo = widget.currentYacht.imo;

    _lengthController.text = widget.currentYacht.length.toString();
    newLength = widget.currentYacht.length;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 16.0,
        title: Text(
          'Edit ${widget.currentYacht.name}',
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
              _editYacht(context);
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
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
              onChanged: (v) {
                setState(
                  () {
                    newName = v;
                  },
                );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              autofocus: true,
              controller: _imoController,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                hintText: 'IMO',
              ),
              onChanged: (v) {
                setState(
                  () {
                    newImo = int.parse(v);
                  },
                );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              autofocus: true,
              controller: _lengthController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Length',
              ),
              onChanged: (v) {
                setState(
                  () {
                    newLength = double.parse(v);
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
