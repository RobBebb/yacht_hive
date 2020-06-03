import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';
import 'package:yacht_hive/yachts/presentation/screens/yacht_view_screen.dart';

class YachtTile extends StatelessWidget {
  final int tileIndex;

  const YachtTile({Key key, this.tileIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<YachtData>(
      builder: (context, yachtData, child) {
        Yacht currentYacht = yachtData.getYacht(tileIndex);
        return Container(
          decoration: BoxDecoration(
              color: tileIndex % 2 == 0 ? Colors.grey : Colors.white),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.lightGreenAccent,
              child: Text(
                currentYacht.name.substring(0, 1),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              currentYacht?.name ?? '',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              currentYacht?.imo.toString() ?? '',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Provider.of<YachtData>(context, listen: false)
                  .setActiveYacht(currentYacht.key);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return YachtViewScreen();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
