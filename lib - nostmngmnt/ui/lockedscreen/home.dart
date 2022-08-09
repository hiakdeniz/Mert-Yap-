import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:mertyapi/ui/lockedscreen/siparisler.dart';
import 'package:mertyapi/ui/lockedscreen/sipver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  int? a;

  Home({this.a});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int? id;

  HomeState({this.id});
  int _currentIndex = 0;
  late int _selectedIndex;
  PageController? _pageController;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  /*void _loadUsername(_username) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      this._username = _prefs.getString("saved_username") ?? "";
    } catch (e) {
      print(e);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 215, 206, 206),

        appBar: AppBar(
          toolbarHeight: 00,
          leading: Container(),
          title: Stack(
            children: <Widget>[
              Positioned(
                left: 20.0,
                top: 15.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20.0)),
                  //  width: 130.0,
                  //  height: 20.0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 2.0),
                child: Text(
                  "",
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
          actions: const <Widget>[],
        ),
        //drawer: AppDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              //opacity: 0.1,
              image: AssetImage("assets/logo.png"),
              fit: BoxFit.none,
            ),
          ),
          child: Stack(
            children: <Widget>[
              bodyContainer(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController!.jumpToPage(index);
          },
          //onItemSelected: (index) => setState(() => _currentIndex = index),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          backgroundColor: Colors.transparent,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Anasayfa'),
              activeColor: Colors.green.shade900,
              inactiveColor: Colors.yellow.shade300,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.apps),
              title: const Text('İşlemler'),
              inactiveColor: Colors.yellow.shade300,
              activeColor: Colors.green.shade900,
              textAlign: TextAlign.center,
            ),
            // BottomNavyBarItem(
            //   icon: Icon(Icons.message),
            //   title: Text(
            //     'Messages test for mes teset test test ',
            //   ),
            //   activeColor: Colors.pink,
            //   textAlign: TextAlign.center,
            // ),
            // BottomNavyBarItem(
            //   icon: Icon(Icons.settings),
            //   title: Text('Settings'),
            //   activeColor: Colors.blue,
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
    /*Stack(
          children: <Widget>[
            Padding(
              child: bodyContainer(),
              padding: const EdgeInsets.only(bottom: 60),
             // padding: EdgeInsets.only(bottom: bottomNavBarHeight),
            ),
           // Align(alignment: Alignment.bottomCenter, child: bottomNav())
          ],
        ),*/
  }

  Widget bodyContainer() {
    return SizedBox.expand(
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          Column(children: [
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  // 09357a
                  // 031b34

                  // colors: [Colors.white38,Colors.green,Colors.blueGrey, ],
                  colors: [Colors.black54, Colors.black, Colors.black38],
                  center: Alignment(0.0, 0.0),
                  focal: Alignment(0.0, 0.0),
                  focalRadius: 3,

                  stops: [0.1, 0.5, 5.5],
                ),
              ),
            )
          ]),
          Container(
              // width: double.infinity,
              // height: double.infinity,
              //color: Colors.black38,
              // margin: const EdgeInsets.only(top: 80, left: 16.0),
              child: Center(
            child: SingleChildScrollView(
              physics: const RangeMaintainingScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  //ButtonBar(),
                  /*  TextButton(
                      style: ButtonStyle(
                       // foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: null,
                      child: Text('TextButton'),
                    ),*/
                  /* RaisedButton(
                        child: Text("Sipariş Ver"),color: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          
                        //style: ElevatedButton.styleFrom(shadowColor: Colors.orange),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Sipver()),
                          );
                        },),*/
                  CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    disabledColor: Colors.black,
                    child: const Text(
                      " Ürün Ekle ",
                      style: TextStyle(fontFamily: 'SourceSansPro'),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sipver()),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    disabledColor: Colors.black,
                    child: const Text(
                      "  Ürünler  ",
                      style: TextStyle(fontFamily: 'SourceSansPro'),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Siparisler()),
                      );
                    },
                  ),

                  // CupertinoButton(child: Text("Siparişler"), onPressed:null)
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
