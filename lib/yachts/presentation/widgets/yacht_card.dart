import 'package:flutter/material.dart';

import '../../domain/yacht.dart';

class YachtCard extends StatelessWidget {
  final Yacht yacht;

  YachtCard(this.yacht);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(yacht.name,
            style: TextStyle(fontSize: 30,),),
            SizedBox(height: 10,),
            Text('IMO: ${yacht.imo.toString()}',),
            SizedBox(height: 10,),
            Text('Length: ${yacht.length.toString()}',),
          ],
        ),
      ),
    );
  }
}
