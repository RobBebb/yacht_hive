import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';
import 'package:yacht_hive/yachts/presentation/widgets/yacht_tile.dart';

class YachtList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return YachtTile(
          titleIndex: index,
        );
      },
      itemCount: Provider.of<YachtData>(context).yachtCount,
      padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 4.0),
    );
  }
}
