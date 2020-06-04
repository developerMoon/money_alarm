import 'package:flutter/material.dart';

class AssetTile extends StatelessWidget {
  final String assetName;
  String assetPrice;
  final Function onTapShowNews;
  AssetTile({this.assetName, this.assetPrice, this.onTapShowNews});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        assetName,
      ),
      trailing: Text(
        assetPrice,
      ),
      onTap: onTapShowNews,
    );
  }
}
