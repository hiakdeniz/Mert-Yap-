import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mertyapi/models/ProductModel.dart';
import 'package:mertyapi/services/database_helper.dart';

class GetController extends GetxController {
  // List<ProductModel?> product = [];
  //List<ProductModel?> product = [];
  // RxList<ProductModel> product = <ProductModel>[].obs;
  //  var product = <ProductModel>[].obs;

  DatabaseHelper? databaseHelper = DatabaseHelper();

  late TextEditingController editingController;
  late DateTime _eventDate;

  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  final TextEditingController controllerproductno = TextEditingController();
  final TextEditingController controlleruser = TextEditingController();
  final TextEditingController controllerPName = TextEditingController();
  final TextEditingController controllerBarcode = TextEditingController();
  final TextEditingController controllerTutar = TextEditingController();
  final TextEditingController controllerSatisFiyat = TextEditingController();
  final TextEditingController controllerStok = TextEditingController();
  final TextEditingController controllerAciklama = TextEditingController();
  final TextEditingController controllerGelis = TextEditingController();
  File? image;
  List<ProductModel?> products = <ProductModel>[];
  bool loading = true;

  RxList product = <ProductModel>[].obs;
  @override
  void onInit() {
    editingController = TextEditingController();
    // generateItems();
    _eventDate = DateTime.now();
    product.value = products;
    super.onInit();
  }

// RxList veya Get pakedindeki değişkenlere değer atarken degiskenAdi.value dememiz gerekiyor.
// Yani bir RxListe değer atamak istiyorsak aşağıdaki gibi atama yapmalıyız. Kullanırkende aynı.
// RxList liste = [].obs;
// liste.value= [1,2,3,4,5];

// Kullanırken de;
// list.value[0];

// sendeki örnekte ise gelen değerleri önce normal bir listeye tayıp
// daha sonra RxListe liste.value=olusturulanNormalListe şeklinde atayabilirsin.

  //DATA ÇEK
  // Future<List<ProductModel?>?> generateItems() async {
  //   if (editingController.text == "") {
  //     var result = await DatabaseHelper.getProduct();
  //     products = result
  //         .map((e) => ProductModel(
  //             PRO_ID: e.PRO_ID,
  //             PCode: e.PCode,
  //             PName: e.PName,
  //             Notes: e.Notes,
  //             TFPath: e.TFPath,
  //             inPrice: e.inPrice,
  //             Barcode: e.Barcode,
  //             Stok: e.Stok,
  //             Bakiye: e.Bakiye,
  //             outPrice: e.outPrice,
  //             eventDate: e.eventDate,
  //             Cancelled: e.Cancelled))
  //         .toList();
  //     print(product.length);
  //   }
  //   return products;
  // }
  Future<List<ProductModel?>> generateItems() async {
    DatabaseHelper.getProduct().then((employees) {
      //_employees = employees;
      // Initialize to the list from Server when reloading...
      products.clear();

      products = employees;

      // Reset the title...
      print("products Length ${products.length}");
    });
    return products;
  }

  Future<List<ProductModel?>> bulbuton(like) async {
    loading = false;
    products.clear();
    products = [];

    DatabaseHelper.getProductBulButon(like).then((employees) {
      products = employees;
      // Reset the title...
      print("products Length ${products.length}");
    });
    return products;
  }

  ///DATA EKLE
  void addData() async {
    final moonLanding = DateTime.parse(_eventDate.toString());

    await databaseHelper?.addproduct(ProductModel(
      PCode: controllerproductno.text,
      PName: controllerPName.text,
      Notes: controllerAciklama.text,
      TFPath: image?.path.toString(),
      inPrice: controllerGelis.text,
      Barcode: controllerBarcode.text,
      Stok: controllerStok.text,
      Bakiye: controllerTutar.text,
      outPrice: controllerSatisFiyat.text,
      eventDate: _eventDate.toString(),
      time: "${moonLanding.hour.toString()} : ${moonLanding.minute.toString()}",
      Cancelled: 0,
    ));
  }

  ///DATA GÜNCELLE
  void updateData(id) async {
    final moonLanding = DateTime.parse(_eventDate.toString());

    await databaseHelper?.updateProduct(ProductModel(
      PRO_ID: id,
      PCode: controllerproductno.text,
      PName: controllerPName.text,
      Notes: controllerAciklama.text,
      TFPath: image?.path.toString(),
      inPrice: controllerGelis.text,
      Barcode: controllerBarcode.text,
      Stok: controllerStok.text,
      Bakiye: controllerTutar.text,
      outPrice: controllerSatisFiyat.text,
      eventDate: _eventDate.toString(),
      time: "${moonLanding.hour.toString()} : ${moonLanding.minute.toString()}",
      Cancelled: 0,
    ));
  }

  ///DATA SİL
  void deleteTask(int proId) async {
    try {
      await databaseHelper?.deleteProduct(proId);
      generateItems();
      // await _goBack();
    } catch (e) {
      print("Error $e");
    }
  }
}
