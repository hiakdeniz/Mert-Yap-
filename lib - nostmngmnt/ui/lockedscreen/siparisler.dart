import 'dart:io';

import 'package:mertyapi/models/ProductModel.dart';
import 'package:mertyapi/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:mertyapi/ui/lockedscreen/sipver.dart';

import 'package:flutter/services.dart';

class Siparisler extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SiparislerState();
  }
}

class SiparislerState extends State<Siparisler>
    with SingleTickerProviderStateMixin {
  TextEditingController editingController = TextEditingController();
  bool loading = true;
  List<ProductModel?> product = [];
  String? _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  /*void _loadUsername(_username) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      this._username = _prefs.getString("saved_username") ?? "";
    } catch (e) {
      print(e);
    }
  }*/

  Future<List<ProductModel?>?> generateItems() async {
    if (editingController.text == "") {
      var result = await DatabaseHelper.getProduct();
      product = result
          .map((e) => ProductModel(
              PRO_ID: e.PRO_ID,
              PCode: e.PCode,
              PName: e.PName,
              Notes: e.Notes,
              TFPath: e.TFPath,
              inPrice: e.inPrice,
              Barcode: e.Barcode,
              Stok: e.Stok,
              Bakiye: e.Bakiye,
              outPrice: e.outPrice,
              eventDate: e.eventDate,
              Cancelled: e.Cancelled))
          .toList();
      print(product.length);
    }
    return product;
  }

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

  Future<List<ProductModel?>> bulbuton(like) async {
    loading = false;
    product = [];
    DatabaseHelper.getProductBulButon(like).then((employees) {
      setState(() {
        //_employees = employees;
        // Initialize to the list from Server when reloading...
        product = employees;
      });
      // Reset the title...
      print("_filterEmployees Length ${employees.length}");
    });
    return product;
  }

  Future getimage() async {
    await Future.delayed(const Duration(milliseconds: 550));
    return true;
  }

  @override
  Widget build(BuildContext context) {
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
                      bulbuton(_scanBarcode.toString());
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
                          editingController.text != ""
                              ? bulbuton(editingController.text)
                              : null;
                        })),
              ],
            ),
          ),
          Expanded(
              flex: 8,
              child: SizedBox.expand(
                  child: FutureBuilder(
                      future: generateItems(),
                      // future: fetchPost(uname,pword,_AboneNo),

                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,

                            /// YATAYDA SIRALAR
                            //scrollDirection: Axis.vertical,
                            itemCount: 1,
                            //shrinkWrap: false,

                            // itemCount: products.length,
                            itemBuilder: (context, index) {
                              return DataTable(
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
                                      label: Expanded(child: Text("Ürün Adı")),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                          child: Text("Geliş / Satış")),
                                    ),
                                  ],
                                  rows: List.generate(
                                    product.length,
                                    (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            product[index]?.TFPath != null
                                                ? FutureBuilder(
                                                    future: getimage(),
                                                    builder: (context, snap) {
                                                      if (snap.hasData) {
                                                        return SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.23,
                                                            child: Image.file(
                                                              File(
                                                                  "${product[index]?.TFPath.toString()}"),
                                                            ));
                                                      } else {
                                                        return SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.23,
                                                            child:
                                                                const CircularProgressIndicator());
                                                      }
                                                    },
                                                  )
                                                : const SizedBox(),
                                          ),
                                          DataCell(
                                            Text(
                                              product[index]?.PName ?? "",
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              "${product[index]?.inPrice} / ${product[index]?.outPrice}",
                                            ),
                                            // "${product[index].Bakiye.toString()}"),
                                          ),
                                        ],
                                        onSelectChanged: (newValue) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Sipver(
                                                PRO_ID: product[index]!.PRO_ID,
                                                Bakiye: product[index]!.Bakiye,
                                                Notes: product[index]!.Notes,
                                                Barcode:
                                                    product[index]!.Barcode,
                                                PCode: product[index]!.PCode,
                                                PName: product[index]!.PName,
                                                Stok: product[index]!.Stok,
                                                TFPath: product[index]!.TFPath,
                                                eventDate:
                                                    product[index]!.eventDate,
                                                inPrice:
                                                    product[index]!.inPrice,
                                                outPrice:
                                                    product[index]!.outPrice,
                                                time: product[index]!.time,
                                              ),
                                            ),
                                          );
                                        }),
                                  ));
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
