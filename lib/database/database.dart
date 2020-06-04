import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:money_alarm/models/asset.dart';
import 'package:money_alarm/models/asset_data.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("create table Asset(name TEXT, price TEXT)");
    });
  }

  addAssetDB(Asset asset) async {
    final db = await database;
    var res = await db.insert("Asset", asset.toMap());
    return res;
  }

  updateAssetDB(Asset newAsset) async {
    final db = await database;
    var res = await db.update("Asset", newAsset.toMap(),
        where: 'name = ?', whereArgs: [newAsset.name]);
    return res;
  }

  getAssetDB(String assetName) async {
    final db = await database;
    var res =
        await db.query("Asset", where: "name = ?", whereArgs: [assetName]);
    return res.isNotEmpty ? Asset.fromMap(res.first) : Null;
  }

  getAllAssetsDB() async {
    final db = await database;
    var res = await db.query("Asset");
    //AssetData assetData;
    List<Asset> list =
        res.isNotEmpty ? res.map((c) => Asset.fromMap(c)).toList() : [];
    //assetData.setAssets(list);

    return list;
  }

  deleteAssetDB(String assetName) async {
    final db = await database;
    db.delete("Asset", where: "name = ?", whereArgs: [assetName]);
  }

  deleteAllDB() async {
    final db = await database;
    db.rawDelete("Delete from Asset");
  }
}
