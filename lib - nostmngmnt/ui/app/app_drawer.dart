import 'package:flutter/material.dart';
import 'package:mertyapi/ui/signin/signin.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      //height: MediaQuery.of(context).size.height,
      child: Drawer(
        semanticLabel: "menü",
        elevation: 25,
        child: SafeArea(
          // color: Colors.grey[50],

          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    //width: 260.0,
                    //height: 125.0,
                    // child: Text("Güneybağ",textAlign: TextAlign.center,),
                    padding:
                        const EdgeInsets.only(left: 55, top: 0, bottom: 0, right: 55),
                    /*  decoration: BoxDecoration(
                      //color: Colors.grey[300],
                      image: DecorationImage(
                        image: AssetImage('asset/image/logo.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),*/
                  ),
                ),
              ),
              /*   ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(""


               */
              /*controller: _username,
                _auth.user.firstname + " " + _auth.user.lastname,
                textScaleFactor: textScaleFactor,
                maxLines: 1,
              ),
              subtitle: Text(""
                _auth.user.id.toString(),
                textScaleFactor: textScaleFactor,
                maxLines: 1,
              ),
               onTap: () {
               Navigator.of(context).popAndPushNamed("/myaccount");
              },
            ),*/
              const SizedBox(
                height: 5,
              ),
              /*Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "Yenilikler",
                textScaleFactor: textScaleFactor,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WhatsNewPage.changelog(
                      title: Text(
                        "Neler yeni",
                        textScaleFactor: textScaleFactor,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buttonText: Text(
                        'Tamam',
                        textScaleFactor: textScaleFactor,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),*/

              const Divider(),

              Expanded(
                flex: 1,
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text(
                    "Anasayfa",
                    style: TextStyle(
                      fontFamily: 'Now',
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomePage()),
                    // );
                  },
                ),
              ),
              /*  Expanded(
                flex: 1,
                child: ListTile(
                  leading: Icon(Icons.alternate_email),
                  title: Text(
                    "Cari Grup 1",

                    style: TextStyle(
                      fontFamily: 'Now',
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Etiket()),
                    );
                  },
                ),
              ),

              Expanded(
                flex: 1,
                child: ListTile(
                  leading: Icon(Icons.group_work),
                  title: Text(
                    "Cari Grup 2",

                    style: TextStyle(
                      fontFamily: 'Now',
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GrupTip()),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "Kullanıcılar",

                    style: TextStyle(
                      fontFamily: 'Now',
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Users()),
                    );
                  },
                ),
              ),*/
              Expanded(
                flex: 1,
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text(
                    "Ürünler",
                    style: TextStyle(
                      fontFamily: 'Now',
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Products()),
                    // );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text(
                    "Kataloglar",
                    style: TextStyle(
                      fontFamily: 'Now',
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Catalog()),
                    // );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  leading: const Icon(Icons.supervised_user_circle),
                  title: const Text(
                    "Müşteriler",
                    style: TextStyle(
                      fontFamily: 'Now',
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AdayMusteri()),
                    // );
                  },
                ),
              ),

              ///çizgi ekler

              Expanded(
                flex: 1,
                child: ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text(
                    "Şifre Değiştir",
                    style: TextStyle(
                      fontFamily: 'Now',
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => PasswordReplace()),
                    // );
                  },
                ),
              ),

              const Divider(),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                      padding: const EdgeInsets.all(16),
                      minWidth: MediaQuery.of(context).size.width,
                      child: const Text(
                        "Çıkış Yap",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Now',
                        ),
                      ),
                      color: const Color(0xff292e4e),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => const LoginPage()),
                            (Route<dynamic> route) => false);
                        // clear();
                      }),
                ),
              ),
              /*   SizedBox( width: MediaQuery
              .of(context)
              .size
              .width,
            height: MediaQuery
                .of(context)
                .size
                .height/1.8,),*/

              /* ListTile(
              leading: Icon(Icons.arrow_back,color: Colors.red,),
              title: Text(
                'Çıkış Yap',
                textScaleFactor: textScaleFactor,
              ),
             */ /* onTap: () => _auth.logout(),*/ /*
            ),*/
            ],
          ),
        ),
      ),
    );
  }
}
