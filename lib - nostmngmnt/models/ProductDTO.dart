// ignore: file_names
// ignore_for_file: non_constant_identifier_names

class ProductDTO {
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
  int? Cancelled;

  ProductDTO(
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
