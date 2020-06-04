import 'dart:convert';

import 'package:flutter/cupertino.dart';

Asset assetFromMap(String str) => Asset.fromMap(json.decode(str));

String assetToMap(Asset data) => json.encode(data.toMap());

class Asset {
  final String name;
  String price;

  Asset({this.name, this.price});

  factory Asset.fromMap(Map<String, dynamic> json) => Asset(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
      };
}
