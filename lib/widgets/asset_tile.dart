import 'package:flutter/material.dart';

class AssetTile extends StatelessWidget {

  final String assetName;
  int assetPrice;

  AssetTile({this.assetName,
              this.assetPrice
        });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        assetName,
//        style: TextStyle(
//          decoration: isChecked ? TextDecoration.lineThrough : null,
//        ),
      ),
      trailing: Text(
//        activeColor: Colors.lightBlueAccent,
//        value: isChecked,
//        onChanged: checkboxCallback,
      assetPrice.toString(),
      ),
      //onLongPress: longPressCallback,
    );
  }
}
