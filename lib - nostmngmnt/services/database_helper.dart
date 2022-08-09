import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:mertyapi/models/ProductDTO.dart';
import 'package:mertyapi/models/ProductModel.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const _databaseVersion = 1;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper? instance = DatabaseHelper?._privateConstructor();
  static DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper = DatabaseHelper._internal();
    return _databaseHelper;
  }

  DatabaseHelper._internal();

  Future<Database?> getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database?> _initializeDatabase() async {
    var lock = Lock();
    Database? _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, "mertyapi.db");
          print("DB's path : $path");

          var file = File(path);

          // check if file exists
          if (!await file.exists()) {
            // Copy from asset
            ByteData data =
                await rootBundle.load(join("assets", "mertyapi.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await File(path).writeAsBytes(bytes);
          }
          // open the database
          _db = await openDatabase(path,
              onCreate: _onCreate, version: _databaseVersion);
        }
      });
    }

    return _db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS urunler ("
        "PRO_ID INTEGER PRIMARY KEY,"
        "PCode TEXT,"
        "PName TEXT,"
        "Notes TEXT,"
        "inPrice TEXT,"
        "Barcode TEXT,"
        "outPrice TEXT,"
        "Stok TEXT,"
        "Bakiye TEXT,"
        "TFPath TEXT,"
        "eventDate TEXT DEFAULT CURRENT_TIMESTAMP,"
        "time	TEXT DEFAULT '00:00',"
        "Cancelled INTEGER"
        ")");
  }

  static tabledelete(String table) async {
    Database? db = DatabaseHelper._database;

    await db?.rawQuery("DELETE FROM $table");
  }

  Future<int?> addproduct(ProductModel productModel) async {
    ProductDTO productDTO = ProductDTO();
    productDTO.PRO_ID = productModel.PRO_ID;
    productDTO.PCode = productModel.PCode;
    productDTO.PName = productModel.PName;
    productDTO.Notes = productModel.Notes;
    productDTO.TFPath = productModel.TFPath;

    productDTO.inPrice = productModel.inPrice;
    productDTO.Barcode = productModel.Barcode;
    productDTO.Stok = productModel.Stok;
    productDTO.Bakiye = productModel.Bakiye;
    productDTO.outPrice = productModel.outPrice;
    productDTO.eventDate = productModel.eventDate;
    productDTO.time = productModel.time;
    productDTO.Cancelled = productModel.Cancelled;

    var db = await getDatabase();
    var result = await db?.insert("urunler", productDTO.toMap());
    print(result);

    return result;
  }

  Future<int?> deleteProduct(int id) async {
    Database? db = DatabaseHelper._database;
    var result =
        await db?.delete("urunler", where: 'PRO_ID = ?', whereArgs: [id]);
    return result;
  }

  static Future<List<ProductModel>> getProductBulButon(String like) async {
    Database? db = DatabaseHelper._database;

    var sonuc = await db?.rawQuery(
        'SELECT * FROM urunler WHERE Barcode LIKE "%$like%" OR PName LIKE "%$like%" OR outPrice LIKE "%$like%";');
    //var sonuc = await db.query("musteriler",where: 'Cancelled = ? ',whereArgs: ["0"]);
    List<ProductModel> result =
        sonuc!.map((e) => ProductModel.fromMap(e)).toList();
    return result;
  }

  static Future<List<ProductModel>> getProduct() async {
    Database? db = DatabaseHelper._database;
    var sonuc =
        await db?.query("urunler", where: 'Cancelled = ?', whereArgs: ["0"]);
    List<ProductModel> result =
        sonuc!.map((e) => ProductModel.fromMap(e)).toList();
    return result;
  }

  Future<int?> updateProduct(ProductModel productModel) async {
    ProductDTO productDTO = ProductDTO();
    productDTO.PRO_ID = productModel.PRO_ID;
    productDTO.PCode = productModel.PCode;
    productDTO.PName = productModel.PName;
    productDTO.Notes = productModel.Notes;
    productDTO.TFPath = productModel.TFPath;

    productDTO.inPrice = productModel.inPrice;
    productDTO.Barcode = productModel.Barcode;
    productDTO.Stok = productModel.Stok;
    productDTO.Bakiye = productModel.Bakiye;
    productDTO.outPrice = productModel.outPrice;
    productDTO.eventDate = productModel.eventDate;
    productDTO.time = productModel.time;

    productDTO.Cancelled = productModel.Cancelled;
    var db = await getDatabase();
    var result = await db?.update("urunler", productDTO.toMap(),
        where: 'PRO_ID = ?', whereArgs: [productDTO.PRO_ID]);
    return result;
  }

  // paswcahenge(int id, String pword) async {
  //   var db = await _getDatabase();
  //   await db.rawQuery(
  //       "UPDATE kullanicilar SET Passw = '$pword' WHERE USR_ID = $id");
  // }
}
