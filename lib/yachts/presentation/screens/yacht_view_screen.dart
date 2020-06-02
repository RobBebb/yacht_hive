import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacht_hive/core/logs/log.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';
import 'package:yacht_hive/yachts/presentation/screens/yacht_edit_screen.dart';

class YachtViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _deleteConfirmation(currentYacht) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Are you sure?',
              style: TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You are about delete ${currentYacht.name}'),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('This action cannot be undone'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Log.d('Deleting ${currentYacht.name}');
                  Provider.of<YachtData>(context, listen: false)
                      .deleteYacht(currentYacht.key);
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(Navigator.defaultRouteName),
                  );
                },
                child: Text(
                  "DELETE",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Log.d('Cancelling');
                  Navigator.of(context).pop();
                },
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Consumer<YachtData>(
      builder: (context, yachtData, child) {
        Yacht currentYacht = yachtData.getActiveYacht();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreenAccent,
            elevation: 16.0,
            title: Text(
              currentYacht.name,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.create),
                iconSize: 24.0,
                color: Colors.blue,
                tooltip: 'Edit',
                onPressed: () {
                  Log.d('Selected to edit');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return YachtEditScreen(
                          currentYacht: currentYacht,
                        );
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                iconSize: 24.0,
                color: Colors.red,
                tooltip: 'Delete',
                onPressed: () {
                  Log.d('Selected to delete');
                  _deleteConfirmation(currentYacht);
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 36.0,
                    color: Colors.grey[300],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'IMO',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          currentYacht?.imo.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 36.0,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Length',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          currentYacht?.length.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
