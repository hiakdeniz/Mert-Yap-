class ProductModel {
  final int? PRO_ID;
  final String? PCode;
  final String? PName;
  final String? Notes;
  final String? TFPath;
  final String? inPrice;
  final String? Barcode;
  final String? Stok;
  final String? Bakiye;
  final String? outPrice;
  final String? eventDate;
  final String? time;
  final int? Cancelled;

  ProductModel(
      {this.PRO_ID,
      this.PCode,
      this.PName,
      this.Notes,
      this.TFPath,
      this.inPrice,
      this.Barcode,
      this.Stok,
      this.Bakiye,
      this.outPrice,
      this.eventDate,
      this.time,
      this.Cancelled});

  factory ProductModel.fromMap(Map data) {
    return ProductModel(
      PRO_ID: data['PRO_ID'],
      PCode: data['PCode'],
      PName: data['PName'],
      Notes: data['Notes'],
      TFPath: data['TFPath'],
      inPrice: data['inPrice'],
      Barcode: data['Barcode'],
      Stok: data['Stok'],
      Bakiye: data['Bakiye'],
      outPrice: data['outPrice'],
      eventDate: data['eventDate'],
      time: data['time'],
      // time: TimeOfDay(
      //       hour: int.parse(data['time'].split(":")[0]),
      //       minute: int.parse(data['time'].split(":")[1])),
      Cancelled: data['Cancelled'],
    );
  }

  factory ProductModel.fromJson(
      int PRO_ID, Cancelled, Map<String, dynamic> data) {
    return ProductModel(
      PRO_ID: PRO_ID,
      PCode: data['PCode'],
      PName: data['PName'],
      Notes: data['Notes'],
      TFPath: data['TFPath'],
      inPrice: data['inPrice'],
      Barcode: data['Barcode'],
      Stok: data['Stok'],
      Bakiye: data['Bakiye'],
      outPrice: data['outPrice'],
      eventDate: data['eventDate'],
      time: data['time'],
      Cancelled: Cancelled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "PRO_ID": PRO_ID,
      "PCode": PCode,
      "PName": PName,
      "Notes": Notes,
      "TFPath": TFPath,
      "inPrice": inPrice,
      "Barcode": Barcode,
      "Stok": Stok,
      "Bakiye": Bakiye,
      "outPrice": outPrice,
      "eventDate": eventDate,
      "time": time,
      "Cancelled": Cancelled,
    };
  }
}
