// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:mertyapi/ui/lockedscreen/sipver.dart';
import 'package:get/get.dart';
import 'package:mertyapi/getx/controller.dart';

import 'package:flutter/services.dart';

class Siparisler extends StatefulWidget {
  const Siparisler({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SiparislerState();
  }
}

class SiparislerState extends State<Siparisler>
    with SingleTickerProviderStateMixin {
  TextEditingController editingController = TextEditingController();
  //List<ProductModel?> product = [];
  String? _scanBarcode = 'Unknown';
  // final GetController _getController = Get.find<GetController>();
  final GetController _getController = Get.put(GetController());

  @override
  void initState() {
    super.initState();
  }

  // Future<List<ProductModel?>?> generateItems() async {
  //   if (editingController.text == "") {
  //     var result = await DatabaseHelper.getProduct();
  //     product = result
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
  //   return product;
  // }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'İptal', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  searchField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 5, right: 5),
      child: TextField(
        controller: editingController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: 'ARA',
        ),
      ),
    );
  }

  Future getimage() async {
    await Future.delayed(const Duration(milliseconds: 550));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Get.find<GetController>();

    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: <Widget>[
            Positioned(
              left: 20.0,
              top: 15.0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20.0)),
                width: 130.0,
                height: 20.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 32.0),
              child: Text(
                "Ürünler",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              // 09357a
              // 031b34

              colors: [
                Color(0xFFCCC653),
                Color(0xFFC1BF39),
                Color(0xFFF7EE4F),
              ],

              center: Alignment(0.0, 0.0),
              focal: Alignment(0.0, 0.0),
              focalRadius: 3,

              stops: [0.1, 0.5, 5.5],
            ),
          ),
        ),
        actions: const <Widget>[
//selectedPos == 1?
        ],
      ),
      body: Column(
        //  mainAxisSize: MainAxisSize.min,
        //  crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      await scanBarcodeNormal();
                      editingController.text = _scanBarcode.toString();
                      _getController.bulbuton(_scanBarcode.toString());
                    },
                    icon: const Icon(FontAwesomeIcons.barcode),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: searchField(),
                ),
                Container(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    width: MediaQuery.of(context).size.width * 0.19,
                    child: RaisedButton(
                        child: const Text("BUL"),
                        onPressed: () {
                          setState(() {
                            editingController.text != ""
                                ? _getController
                                    .bulbuton(editingController.text)
                                : null;
                          });
                        })),
              ],
            ),
          ),
          Expanded(
              flex: 8,
              child: SizedBox.expand(
                  child: FutureBuilder(
                      future: //editingController.text == ""
                          _getController.bulbuton(editingController.text),
                      //: bulbuton(editingController.text),
                      // future: fetchPost(uname,pword,_AboneNo),

                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,

                            /// YATAYDA SIRALAR
                            //scrollDirection: Axis.vertical,
                            itemCount: 1,
                            //shrinkWrap: false,

                            // itemCount: products.length,
                            itemBuilder: (context, index) {
                              // return Obx(() => DataTable(
                              return GetBuilder<GetController>(
                                  builder: (_getController) => DataTable(
                                      showCheckboxColumn: false,
                                      sortAscending: true,
                                      columnSpacing: 68,
                                      dataRowHeight: 70,
                                      columns: const [
                                        DataColumn(
                                          label: Expanded(
                                            child: Icon(
                                              FontAwesomeIcons.camera,
                                              size: 18.0,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label:
                                              Expanded(child: Text("Ürün Adı")),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                              child: Text("Geliş / Satış")),
                                        ),
                                      ],
                                      rows: List.generate(
                                        _getController.products.length,
                                        (index) => DataRow(
                                            cells: [
                                              DataCell(
                                                _getController.products[index]
                                                            ?.TFPath !=
                                                        null
                                                    ? FutureBuilder(
                                                        future: getimage(),
                                                        builder:
                                                            (context, snap) {
                                                          if (snap.hasData) {
                                                            return SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2,
                                                                child:
                                                                    Image.file(
                                                                  File(
                                                                      "${_getController.products[index]?.TFPath.toString()}"),
                                                                ));
                                                          } else {
                                                            return SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2,
                                                                child:
                                                                    const CircularProgressIndicator());
                                                          }
                                                        },
                                                      )
                                                    : const SizedBox(),
                                              ),
                                              DataCell(
                                                Text(
                                                  _getController.products[index]
                                                          ?.PName ??
                                                      "",
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  "${_getController.products[index]?.inPrice} / ${_getController.products[index]?.outPrice}",
                                                ),
                                                // "${products[index].Bakiye.toString()}"),
                                              ),
                                            ],
                                            onSelectChanged: (newValue) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Sipver(
                                                    PRO_ID: _getController
                                                        .products[index]
                                                        ?.PRO_ID,
                                                    Bakiye: _getController
                                                        .products[index]
                                                        ?.Bakiye,
                                                    Notes: _getController
                                                        .products[index]?.Notes,
                                                    Barcode: _getController
                                                        .products[index]
                                                        ?.Barcode,
                                                    PCode: _getController
                                                        .products[index]?.PCode,
                                                    PName: _getController
                                                        .products[index]?.PName,
                                                    Stok: _getController
                                                        .products[index]?.Stok,
                                                    TFPath: _getController
                                                        .products[index]
                                                        ?.TFPath,
                                                    eventDate: _getController
                                                        .products[index]
                                                        ?.eventDate,
                                                    inPrice: _getController
                                                        .products[index]
                                                        ?.inPrice,
                                                    outPrice: _getController
                                                        .products[index]
                                                        ?.outPrice,
                                                    time: _getController
                                                        .products[index]?.time,
                                                  ),
                                                ),
                                              );
                                            }),
                                      )));
                              // )));
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })))
        ],
      ),
    );
  }
}
