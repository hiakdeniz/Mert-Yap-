class ProfileModel {
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
  String? passw;
  String? usern;
  String? kapanis;

  ProfileModel(
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
      this.telefon11,
      this.passw,
      this.usern,
      this.kapanis);

  ProfileModel.fromJson(Map<String, dynamic> json) {
    mustKod = json['MustKod'];
    mustAdi = json['MustAdi'];
    adres = json['Adres'];
    email1 = json['Email1'];
    tel1 = json['Tel1'];
    aboneNo = json['AboneNo'];
    adi = json['Adi'];
    adres1 = json['Adres1'];
    telefon1 = json['Telefon1'];
    enabled = json['Enabled'];
    zoneAdi = json['ZoneAdi'];
    telefon11 = json['Telefon11'];
    passw = json['Passw'];
    usern = json['Usern'];
    kapanis = json['Kapanis'];
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
    data['Passw'] = passw;
    data['Usern'] = usern;
    data['Kapanis'] = kapanis;
    return data;
  }
}
