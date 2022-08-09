// ignore_for_file: deprecated_member_use, non_constant_identifier_names, avoid_print

import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:mertyapi/getx/controller.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mertyapi/services/database_helper.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class Sipver extends StatefulWidget {
  int? PRO_ID;
  String? PCode;
  String? PName;
  String? Notes;
  String? TFPath;
  String? inPrice;
  String? Barcode;
  String? Stok;
  String? Bakiye;
  String? outPrice;
  String? eventDate;
  String? time;

  Sipver({
    Key? key,
    this.PRO_ID,
    this.PName,
    this.Notes,
    this.TFPath,
    this.inPrice,
    this.Barcode,
    this.Stok,
    this.PCode,
    this.Bakiye,
    this.outPrice,
    this.eventDate,
    this.time,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SipverState();
  }
}

class SipverState extends State<Sipver> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  late DateTime _eventDate;

  String _scanBarcode = 'Unknown';
  bool addNewTask = true;
  File? _image;
  final picker = ImagePicker();
  PickedFile? _imageFile;
  dynamic _pickImageError;
  bool isVideo = false;

  DatabaseHelper? databaseHelper = DatabaseHelper();
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;
  final GetController _getController = Get.put(GetController());

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _eventDate = DateTime.now();
    //_controllerproductno.text = "a";
    //_controlleruser.text = "a";
    loadInfo();
    _waitdb();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    //animation
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(end: 2.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
    if (_status == AnimationStatus.dismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Future _waitdb() async {
    try {
      databaseHelper;
    } catch (e) {
      print(e);
    }
  }

  void deleteTask(int proId) async {
    try {
      await databaseHelper?.deleteProduct(proId);

      // await _goBack();
    } catch (e) {
      print("Error $e");
    }
  }

  void loadInfo() async {
    bool info = widget.PRO_ID == null ? true : false;

    if (!info) {
      try {
        _getController.controllerproductno.text = widget.PCode.toString();
        _getController.controlleruser.text = widget.TFPath.toString();
        _getController.controllerPName.text = widget.PName.toString();
        _getController.controllerBarcode.text = widget.Barcode.toString();
        _getController.controllerTutar.text = widget.Bakiye.toString();
        _getController.controllerSatisFiyat.text = widget.outPrice.toString();
        _getController.controllerStok.text = widget.Stok.toString();
        _getController.controllerAciklama.text = widget.Notes.toString();
        _getController.controllerGelis.text = widget.inPrice.toString();
        _getController.image = _image;

        print("BİLGİLER ÇEKİLDİ");
      } catch (e) {
        print("Error $e");
      }
    } else {
      print("BİLGİLER ÇEKİLMEDİ NEW İNSERT");
      _getController.controllerproductno.text = "";
      _getController.controlleruser.text = "";
      _getController.controllerPName.text = "";
      _getController.controllerBarcode.text = "";
      _getController.controllerTutar.text = "";
      _getController.controllerSatisFiyat.text = "";
      _getController.controllerStok.text = "";
      _getController.controllerAciklama.text = "";
      _getController.controllerGelis.text = "";
    }
  }

  // void saveTask() async {
  //   addNewTask = widget.PRO_ID == null ? true : false;
  //   final moonLanding = DateTime.parse(_eventDate.toString());

  //   try {
  //     if (addNewTask) {
  //       await databaseHelper?.addproduct(ProductModel(
  //         PCode: _controllerproductno.text,
  //         PName: _controllerPName.text,
  //         Notes: _controllerAciklama.text,
  //         TFPath: _image?.path.toString(),
  //         inPrice: _controllerGelis.text,
  //         Barcode: _controllerBarcode.text,
  //         Stok: _controllerStok.text,
  //         Bakiye: _controllerTutar.text,
  //         outPrice: _controllerSatisFiyat.text,
  //         eventDate: _eventDate.toString(),
  //         time:
  //             "${moonLanding.hour.toString()} : ${moonLanding.minute.toString()}",
  //         Cancelled: 0,
  //       ));
  //     } else {
  //       await databaseHelper?.updateProduct(ProductModel(
  //         PRO_ID: widget.PRO_ID,
  //         PCode: _controllerproductno.text,
  //         PName: _controllerPName.text,
  //         Notes: _controllerAciklama.text,
  //         TFPath: _image?.path.toString() ?? widget.TFPath,
  //         inPrice: _controllerGelis.text,
  //         Barcode: _controllerBarcode.text,
  //         Stok: _controllerStok.text,
  //         Bakiye: _controllerTutar.text,
  //         outPrice: _controllerSatisFiyat.text,
  //         eventDate: _eventDate.toString(),
  //         time:
  //             "${moonLanding.hour.toString()} : ${moonLanding.minute.toString()}",
  //         Cancelled: 0,
  //       ));
  //     }
  //     /*     if(_image!=null) {
  //       int cus_id = await DatabaseHelper.maxcusid();
  //       cus_id = widget.CUS_ID == null ? cus_id + 1 : widget.CUS_ID;
  //       await databaseHelper.adddetay(detayModel(
  //         FName: _image.path.substring(0, 10),
  //         FPath: _image.path,
  //         GUID: widget.GUID,
  //         TUR: "musteriresim",
  //         CUS_ID: cus_id,
  //         Cancelled: 0,
  //       ));
  //     }*/

  //   } catch (e) {
  //     print("Error $e");
  //   }
  // }

  /* void deleteTask() async {
    try {
      await databaseHelper.uDeleteMusteri(MusteriModel(
        CUS_ID: widget.CUS_ID,
        Name: widget.Unvan,
        Unvan: widget.Unvan,
        Web: widget.Web,
        Firma_Adi: widget.Firma_Adi,
        Adress: widget.Adress,
        FPath: widget.FPath,
        Auth_Per: widget.Auth_Per,
        GSM: widget.GSM,
        Email: widget.Email,
       GUID: widget.GUID,

        Cancelled:0,
      ));
      setState(() {
        processing = false;
      });
     // await _goBack();
    } catch (e) {
      print("Error $e");
    }
  }*/

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
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

  // Platform messages are asynchronous, so we initialize in an async method.
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
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 1);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _getController.image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _displayPickImageDialog(BuildContext context,
      Future<void> Function(double? maxWidth, double? maxHeight) param1) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: _getController.maxWidthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: "Enter maxWidth if desired"),
                ),
                TextField(
                  controller: _getController.maxHeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: "Enter maxHeight if desired"),
                ),
                TextField(
                  controller: _getController.qualityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Enter quality if desired"),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    double? width = _getController
                            .maxWidthController.text.isNotEmpty
                        ? double.parse(_getController.maxWidthController.text)
                        : null;
                    double? height = _getController
                            .maxHeightController.text.isNotEmpty
                        ? double.parse(_getController.maxHeightController.text)
                        : null;
                    int? quality =
                        _getController.qualityController.text.isNotEmpty
                            ? int.parse(_getController.qualityController.text)
                            : null;

                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    if (isVideo) {
      final PickedFile? file = await _picker.getVideo(
          source: source, maxDuration: const Duration(seconds: 10));
    } else {
      await _displayPickImageDialog(context!, (
        double? maxWidth,
        double? maxHeight,
      ) async {
        try {
          final pickedFile = await _picker.getImage(
            source: source, imageQuality: 1,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            //imageQuality: quality,
          );
          setState(() {
            _imageFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {}
  }

  Widget _previewImage() {
    if (_imageFile != null) {
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
        return Image.network(_imageFile!.path);
      } else {
        return Semantics(
            child: Image.file(File(_imageFile!.path)),
            label: 'image_picker_example_picked_image');
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
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
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  widget.PRO_ID == null ? "Ürün Oluştur" : "Ürün Güncelle",
                  style: const TextStyle(
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
//0xff den sonrası normal
                colors: [
                  Color(0xFFA2A004),
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
          actions: <Widget>[
            IconButton(
              onPressed: () {
                getImage();
                //_previewImage();
              },
              icon: const Icon(
                FontAwesomeIcons.camera,
                size: 28.0,
              ),
            ),

          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          //_previewImage(),
          Center(
              // ignore: unnecessary_null_comparison
              child: _image != null
                  ? _image == null
                      ? const Text(
                          '') //const Text('Kartvizit yüklemek için sağ üstteki ikona tıklayın.')
                      : Image.file(
                          File(_image!.path),
                          height:
                              (MediaQuery.of(context).size.height * 30) / 100,
                          width: (MediaQuery.of(context).size.width * 40) / 100,
                        ) //Image.fil
                  : widget.TFPath != null
                      ? Builder(
                          builder: (BuildContext context) => SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height * 30) /
                                      100,
                              width: (MediaQuery.of(context).size.width * 30) /
                                  100,
                              //  height: MediaQuery.of(context).size.height * 0.30,
                              child: Image.file(
                                File("${widget.TFPath}"),
                                height:
                                    (MediaQuery.of(context).size.height * 30) /
                                        100,
                                width:
                                    (MediaQuery.of(context).size.width * 40) /
                                        100,
                              )),
                        )
                      : Container()),
          const SizedBox(
            height: 15,
          ),

          Form(
              key: formKey,
              child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // SizedBox(
                    //   width: (MediaQuery.of(context).size.width * 50) / 100,
                    //   child: TextFormField(
                    //     //minLines: 3,
                    //     //maxLines: 5,
                    //     // readOnly: true,
                    //     //  enabled: false,
                    //     controller: _controllerproductno,
                    //     toolbarOptions: ToolbarOptions(selectAll: true),
                    //     textInputAction: TextInputAction.next,
                    //     decoration: const InputDecoration(
                    //       labelText: "Ürün No",
                    //     ),

                    //     obscureText: false,
                    //     keyboardType: TextInputType.text,

                    //     autocorrect: false,
                    //   ),
                    // ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width * 30) / 100,
                      child: Transform(
                        alignment: FractionalOffset.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0015)
                          ..rotateY(pi * _animation.value),
                        //..rotateY(pi * _animation.value),
                        child: widget.PRO_ID == null
                            ? Card(
                                child: _animation.value <= 0.1
                                    ? SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    30) /
                                                100,
                                        child: Container(
                                            color: Colors.deepPurple,
                                            child: Center(
                                              child: Container(
                                                width: 240,
                                                height: 300,
                                                color: Colors.grey,
                                              ),
                                            )))
                                    : SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    30) /
                                                100,
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Eklenme Tarihi",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            InkWell(
                                              child:
                                                  //
                                                  Text(
                                                "${_eventDate.day.toString().padLeft(2, '0')} - ${_eventDate.month.toString().padLeft(2, '0')} - ${_eventDate.year}\n${_eventDate.hour.toString().padLeft(2, '0')}:${_eventDate.minute.toString().padLeft(2, '0')}",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              padding: const EdgeInsets.only(
                                                  left: 55),
                                            )
                                          ],
                                        ),
                                      ),
                              )
                            : Card(
                                child: _animation.value <= 0.1
                                    ? SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    30) /
                                                100,
                                        child: Container(
                                            color: Colors.deepPurple,
                                            child: Center(
                                              child: Container(
                                                width: 240,
                                                height: 300,
                                                color: Colors.grey,
                                              ),
                                            )))
                                    : SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    30) /
                                                100,
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Eklenme Tarihi",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            InkWell(
                                              child:
                                                  //
                                                  Text(
                                                // "${DateFormat("dd-MM-yyyy hh:mm:ss").parse(widget.eventDate.toString())}",
                                                "${DateTime.parse(widget.eventDate.toString())}",
                                                // "${widget.eventDate.toString().padLeft(2, '0')} - ${widget.eventDate.toString().padLeft(2, '0')} - ${_eventDate.year}\n${_eventDate.hour.toString().padLeft(2, '0')}:${_eventDate.minute.toString().padLeft(2, '0')}",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              padding: const EdgeInsets.only(
                                                  left: 55),
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                      ),
                    ),
                  ],
                ),

                Card(
                  margin: const EdgeInsets.all(30),
                  shadowColor: Colors.black,
                  color: Colors.grey.shade100,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        //padding: EdgeInsets.only(left: 10,right: 10),margin:EdgeInsets.only(left: 10,right: 10) ,
                        child: ListTile(
                          title: TextFormField(
                            //minLines: 3,
                            //maxLines: 5,
                            //controller: _controllerPName,
                            controller: _getController.controllerPName,
                            toolbarOptions:
                                const ToolbarOptions(selectAll: true),
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: "Ürün Adı",
                            ),

                            obscureText: false,
                            keyboardType: TextInputType.text,

                            autocorrect: false,
                          ),
                        ),
                      ),
                      Container(
                        //padding: EdgeInsets.only(left: 10,right: 10),margin:EdgeInsets.only(left: 10,right: 10) ,
                        child: ListTile(
                          title: TextFormField(
                            //minLines: 3,
                            //maxLines: 5,
                            // controller: _controllerAciklama,
                            controller: _getController.controllerAciklama,

                            toolbarOptions:
                                const ToolbarOptions(selectAll: true),
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: "Açıklama",
                            ),

                            obscureText: false,
                            keyboardType: TextInputType.text,

                            autocorrect: false,
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          toolbarOptions: const ToolbarOptions(selectAll: true),
                          textInputAction: TextInputAction.go,
                          decoration: const InputDecoration(
                            labelText: "Geliş Fiyatı",
                          ),
                          maxLength: 11,
                          controller: _getController.controllerGelis,
                          keyboardType: TextInputType.phone,
                          autocorrect: false,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width * 25) /
                                        100,
                                child: TextFormField(
                                  toolbarOptions:
                                      const ToolbarOptions(selectAll: true),
                                  textInputAction: TextInputAction.next,
                                  onChanged: (value) {
                                    setState(() {
                                      // int? a = int.tryParse(_controllerFiyat.text)??0;
                                      double? a = double.tryParse(_getController
                                              .controllerSatisFiyat.text) ??
                                          0;
                                      double? b = double.tryParse(_getController
                                              .controllerStok.text) ??
                                          0;
                                      _getController.controllerTutar.text =
                                          (a * b).toString().replaceAll(
                                              RegExp(r'\B(?=(\d{3})+(?!\d))'),
                                              ',');
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Satış Fiyatı",
                                  ),
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  controller:
                                      _getController.controllerSatisFiyat,
                                  autocorrect: false,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width * 25) /
                                        100,
                                child: TextFormField(
                                  toolbarOptions:
                                      const ToolbarOptions(selectAll: true),
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    labelText: "Stok",
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      double? a = double.tryParse(_getController
                                              .controllerSatisFiyat.text) ??
                                          0;
                                      double? b = double.tryParse(_getController
                                              .controllerStok.text) ??
                                          0;
                                      _getController.controllerTutar.text =
                                          (a * b).toString().replaceAll(
                                              RegExp(r'\B(?=(\d{3})+(?!\d))'),
                                              ',');
                                    });
                                  },
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  controller: _getController.controllerStok,
                                  autocorrect: false,
                                ),
                              )
                            ],
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 5, top: 30),
                            child: Icon(
                              FontAwesomeIcons.arrowDown,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                          title: Container(
                        //  width: (MediaQuery.of(context).size.width * 0.4),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          toolbarOptions: const ToolbarOptions(selectAll: true),
                          textInputAction: TextInputAction.next,
                          enabled: false,
                          decoration: const InputDecoration(
                            label: Center(
                              child: Text("Bakiye"),
                            ),
                          ),
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          controller: _getController.controllerTutar,
                          autocorrect: false,
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                ///ESPANSİONTİLE
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ExpansionTile(
                        title: const Text(
                          "Barkod Okutma",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              //color: Colors.grey.shade300,
                            ),
                            width: MediaQuery.of(context).size.width - 20,
                            margin: const EdgeInsets.only(bottom: 20),
                            //height: 370,
                          ),
                          InkWell(
                            onTap: () async {
                              scanBarcodeNormal().then((value) => _getController
                                  .controllerBarcode
                                  .text = _scanBarcode.toString());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                  "Barkod \nOkut",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                SizedBox(width: 40.0),
                                Icon(
                                  FontAwesomeIcons.barcode,
                                  size: 58.0,
                                )
                              ],
                            ),
                          ),
                          Container(
                            //padding: EdgeInsets.only(left: 10,right: 10),margin:EdgeInsets.only(left: 10,right: 10) ,
                            child: ListTile(
                              title: TextFormField(
                                //minLines: 3,
                                //maxLines: 5,
                                controller: _getController.controllerBarcode,
                                toolbarOptions:
                                    const ToolbarOptions(selectAll: true),
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  // border: InputBorder.none,

                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        top: 5,
                                        right:
                                            15), // add padding to adjust icon
                                    child: Icon(FontAwesomeIcons.barcode),
                                  ),
                                ),

                                obscureText: false,
                                keyboardType: TextInputType.text,

                                autocorrect: false,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ]),
                  ],
                ),
                widget.PRO_ID == null
                    ? ListTile(
                        title: RaisedButton(
                          child: const Text(
                            "Oluştur",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.yellow.shade700,
                          onPressed: () {
                            final form = formKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              _getController.addData();

                              //saveTask();
                              CoolAlert.show(
                                onConfirmBtnTap: () async {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  await Future.delayed(
                                      const Duration(milliseconds: 1000));
                                },
                                context: context,
                                barrierDismissible: true,
                                confirmBtnText: "Tamam",
                                type: CoolAlertType.success,
                                title: "Ürün Başarıyla Eklendi.",
                              );
                            }
                          },
                        ),
                      )
                    : ListTile(
                        title: RaisedButton(
                          child: const Text(
                            "Güncelle",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.yellow.shade700,
                          onPressed: () {
                            CoolAlert.show(
                              onConfirmBtnTap: () async {
                                _getController.updateData(widget.PRO_ID);
                                // saveTask();
                                Get.back();
                                Get.back();
                                Get.back();
                                await Future.delayed(
                                    const Duration(milliseconds: 1000));
                              },
                              context: context,
                              barrierDismissible: true,
                              confirmBtnText: "Tamam",
                              type: CoolAlertType.success,
                              title: "Ürün Başarıyla Güncellendi.",
                            );
                          },
                        ),
                        trailing: RaisedButton(
                          child: const Text(
                            "SİL",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red.shade900,
                          onPressed: () {
                            CoolAlert.show(
                              onConfirmBtnTap: () async {
                                _getController
                                    .deleteTask(widget.PRO_ID!.toInt());
                                //deleteTask(widget.PRO_ID!.toInt());
                                Get.back();
                                Get.back();
                                print(
                                  _getController.products.length,
                                );
                                await Future.delayed(
                                    const Duration(milliseconds: 1000));
                              },
                              context: context,
                              barrierDismissible: true,
                              confirmBtnText: "Tamam",
                              cancelBtnText: "İptal",
                              type: CoolAlertType.confirm,
                              title: "Müşteri Silinecek Onaylıyor Musunuz ?",
                            );
                          },
                        ),
                      )
              ]))
        ])));
  }
}
