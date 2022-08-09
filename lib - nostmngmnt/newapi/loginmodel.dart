///BANA DÖNEN
class LoginResponseModel {
  int? mustKod;
  String? mustAdi;
  String? adres;
  String? email1;
  String? tel1;
  int? aboneNo;
  String? adi;
  String? adres1;
  String? telefon1;
  bool? enabled;
  String? zoneAdi;
  String? telefon11;
  int? isok;
  int? firmasayisi;

  LoginResponseModel({
    this.mustKod,
    this.mustAdi,
    this.adres,
    this.email1,
    this.tel1,
    this.aboneNo,
    this.adi,
    this.adres1,
    this.telefon1,
    this.enabled,
    this.zoneAdi,
    this.isok,
    this.telefon11,
    this.firmasayisi,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      mustKod: json['MustKod'] ?? 0,
      mustAdi: json['MustAdi'] ?? "",
      adres: json['Adres'] ?? "",
      email1: json['Email1'] ?? "",
      tel1: json['Tel1'] ?? "",
      aboneNo: json['AboneNo'] ?? 0,
      adi: json['Adi'] ?? "",
      adres1: json['Adres1'] ?? "",
      telefon1: json['Telefon1'] ?? "",
      enabled: json['Enabled'] ?? false,
      zoneAdi: json['ZoneAdi'] ?? "",
      telefon11: json['Telefon11'] ?? "",
      isok: json['isok'],
      firmasayisi: json['Firma_Sayisi'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MustKod'] = mustKod;
    data['MustAdi'] = mustAdi;
    data['Adres'] = adres;
    data['Email1'] = email1;
    data['Tel1'] = tel1;
    data['AboneNo'] = aboneNo;
    data['Adi'] = adi;
    data['Adres1'] = adres1;
    data['Telefon1'] = telefon1;
    data['Enabled'] = enabled;
    data['ZoneAdi'] = zoneAdi;
    data['Telefon11'] = telefon11;
    data['isok'] = isok;
    data['Firma_Sayisi'] = firmasayisi;
    return data;
  }

/* factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      aboneNo: json["aboneNo"] != null ? json["aboneNo"] : "",

    );
  }*/
}

///BENİM GÖNDERDİĞİM
class LoginRequestModel {
  String? usern;
  String? passw;
  String? ck;
  String? dv;
  String? dt;

  LoginRequestModel({this.usern, this.passw, this.dt, this.dv, this.ck});

  LoginRequestModel.fromJson(Map json) {
    usern = json["usern"];
    passw = json["passw"];
    ck = json["ck"];
    dv = json["dv"];
    dt = json["dt"];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'usern': usern,
      'passw': passw,
      'ck': ck,
      'dv': dv,
      'dt': dt,
    };

    return map;
  }
}
