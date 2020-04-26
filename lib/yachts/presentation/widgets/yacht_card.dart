import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/yacht.dart';
import '../../application/yachts.dart';
import '../screens/edit_yacht_screen.dart';

class YachtCard extends StatelessWidget {
  final Yacht yacht;

  YachtCard(this.yacht);

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
                    yacht.name,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'IMO: ${yacht.imo.toString()}',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Length: ${yacht.length.toString()}',
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
                          arguments: yacht);
                    },
                    color: Theme.of(context).primaryColorDark,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await Provider.of<Yachts>(
                        context,
                        listen: false,
                      ).removeYacht(
                        yacht.id,
                      );
                    },
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
