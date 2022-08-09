import 'dart:convert';

import 'package:http/http.dart' as http;
import 'loginmodel.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestMpdel) async {
    String url = "http://212.156.55.222:99/APIV2.asmx/Login";
    // String url="http://halilakdeniz.akillisirketler.com/api.asmx/Login";

    final response =
        await http.post(Uri.parse(url), body: requestMpdel.toJson());
    //final jsonresponse = json.decode(response.body);

    return LoginResponseModel.fromJson(json.decode(response.body));
  }
}
