import 'package:mertyapi/ui/signin/signin.dart';
import 'package:mertyapi/services/database_helper.dart';
import 'package:flutter/material.dart';

// void main() async {
//   var l1 = [1, 2, 3];
//   var l2 = l1;

//   // ignore: avoid_print
//   print(l2);
// }

void main() async {
  runApp(
    const MyApp(),
  );
}

//void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DatabaseHelper? dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    dbHelper?.getDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      theme: ThemeData(fontFamily: 'SourceSansPro'),
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      title: 'Mert Yapı',
      home: const LoginPage(),
    );
  }
}


///İOSTAKİ DEVİCEİNFO
///