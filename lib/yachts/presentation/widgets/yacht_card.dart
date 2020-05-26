import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../domain/yacht.dart';
// import '../../application/yachts.dart';
import '../screens/edit_yacht_screen.dart';

  const String yachtBoxName = 'yacht';

class YachtCard extends StatefulWidget {
  final Yacht yacht;
  final int yachtIndex;

  YachtCard(this.yacht, this.yachtIndex);

  @override
  _YachtCardState createState() => _YachtCardState();
}

class _YachtCardState extends State<YachtCard> {
  
  void onYachtDelete() {
    Box<Yacht> yachtBox = Hive.box<Yacht>(yachtBoxName);
    yachtBox.deleteAt(widget.yachtIndex);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    widget.yacht.name,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'IMO: ${widget.yacht.imo.toString()}',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Length: ${widget.yacht.length.toString()}',
                  ),
                ],
              ),
              SizedBox(width: 10),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushNamed(EditYachtScreen.routeName,
                          arguments: widget.yachtIndex);
                    },
                    color: Theme.of(context).primaryColorDark,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: onYachtDelete,
                    color: Theme.of(context).errorColor,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
