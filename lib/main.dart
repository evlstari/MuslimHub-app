import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_flutter/view/home.dart';
import 'package:project_flutter/view/page/settings.dart';
import 'package:project_flutter/view/splashscreen.dart';
import 'package:project_flutter/viewModel/helper/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({ Key? key }) : super(key: key);

  ThemeData gelap = ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Poppins",
      primaryColor: HexColor("#B068D0"),
      primarySwatch: Colors.purple,
      );

  ThemeData terang = ThemeData(
      brightness: Brightness.light,
      fontFamily: "Poppins",
      primaryColor: HexColor("#B068D0"),
      primarySwatch: Colors.purple,
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: notifier.darkMode ? gelap : terang,
              home: SplashScreen());
        },
      ),
    );
  }
}
