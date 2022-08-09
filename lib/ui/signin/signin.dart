import 'package:mertyapi/ui/lockedscreen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  final String? username = "mertyapi";

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool isApiCallProcess = false;

  String? usern, pasw;

  final formKey = GlobalKey<FormState>();
  final form = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? _controllerUsername, _controllerPassword;

  @override
  initState() {
    _controllerUsername = TextEditingController(text: widget.username);
    _controllerPassword = TextEditingController();
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          const SizedBox(height: 60.0),
          Stack(
            children: <Widget>[
              Positioned(
                left: 20.0,
                top: 15.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20.0)),
                  width: 70.0,
                  height: 20.0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 32.0),
                child: Text(
                  "Giriş",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(58.0),
                  child: Image.asset(
                    "assets/logo.png",
                    height: (MediaQuery.of(context).size.height * 30) / 100,
                    width: (MediaQuery.of(context).size.width * 40) / 100,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
                  child: ListTile(
                    title: TextFormField(
                      toolbarOptions: const ToolbarOptions(
                          selectAll: true, copy: true, paste: true),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: "Kullanıcı Adı",
                        labelStyle: TextStyle(
                          fontFamily: 'Now',
                        ),
                        icon: Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Icon(Icons.person)),
                      ),
                      validator: (val) => val!.isEmpty ? "Boş Geçilemez" : null,
                      // onSaved: (val) => _username = val,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      controller: _controllerUsername,
                      autocorrect: false,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
                  child: ListTile(
                    title: TextFormField(
                      toolbarOptions: const ToolbarOptions(selectAll: true),
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: "Şifre",
                        labelStyle: TextStyle(
                          fontFamily: 'Now',
                        ),
                        icon: Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Icon(Icons.lock)),
                      ),

                      validator: (val) => val!.isEmpty ? "Boş Geçilemez" : null,
                      //onSaved: (val) => _password = val,
                      obscureText: true,
                      controller: _controllerPassword,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(right: 16.0),
                    alignment: Alignment.centerRight,
                    child: const Text("Şifreni Mi Unuttun?")),
                const SizedBox(height: 120.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                    color: Colors.yellow,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0))),
                    onPressed: () async {
                      final form = formKey.currentState;

                      if (form!.validate()) {
                        form.save();

                        if (_controllerUsername?.text == "mertyapi" &&
                            _controllerPassword?.text == "5580") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        } else {
                          CoolAlert.show(
                            barrierDismissible: true,
                            context: context,
                            showCancelBtn: false,
                            //confirmBtnText: "Tamam",
                            type: CoolAlertType.error,
                            title: "Kullanıcı Adı Veya Şifre Hatalı!",
                          );
                        }

                        final snackbar = SnackBar(
                          duration: const Duration(seconds: 3),
                          content: Row(
                            children: const <Widget>[
                              CircularProgressIndicator(),
                              Text("  Giriş Yapılıyor...")
                            ],
                          ),
                        );
                        // ignore: deprecated_member_use
                        _scaffoldKey.currentState!.showSnackBar(snackbar);
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text(
                          "GİRİŞ YAP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        SizedBox(width: 40.0),
                        Icon(
                          FontAwesomeIcons.arrowRight,
                          size: 18.0,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ])));
  }
}
