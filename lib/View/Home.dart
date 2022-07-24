import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_flutter/View/page/Dashboard.dart';
import 'package:project_flutter/View/page/HadistScreen.dart';
import 'package:project_flutter/View/page/locatinscreen.dart';
import 'package:project_flutter/view/page/halamanevi.dart';
import 'package:project_flutter/viewModel/helper/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screen = [Dashboard(), HadistScreen(), LocationScreen()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          body: PageStorage(bucket: bucket, child: currentScreen),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HalamanEvi()));
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            // color: notifier.darkMode ? Colors.black12 : Colors.white ,
            elevation: 16,
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Dashboard();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/quran.svg",
                          color: currentTab == 0
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                        Text(
                          "Surat",
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 120,
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = HadistScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book,
                          color: currentTab == 1
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                        Text(
                          "Hadist",
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
