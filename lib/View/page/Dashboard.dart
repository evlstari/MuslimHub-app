import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:project_flutter/Models/Surat.dart';
import 'package:project_flutter/View/Drawer.dart';
import 'package:project_flutter/View/page/Bookmark.dart';
import 'package:project_flutter/view/page/detailsurat.dart';
import 'package:project_flutter/viewModel/api_service.dart';
import 'package:project_flutter/viewModel/helper/theme.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      ApiService.getSuratFromAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Row(
              children: [
                Text(
                  "Muslim",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text(
                  "Hub",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: HexColor("#FFCF89")),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Bookmark()));
                },
                icon: Icon(Icons.bookmark_border_outlined),
                color: HexColor("#B068D0"),
              )
            ],
            leading: Builder(
              builder: (context) => IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/jam_menu.svg", color: Colors.white,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            // backgroundColor: notifier.darkMode ? Colors.black12 :Colors.white ,
          ),
          body: Container(
            // color: notifier.darkMode ? Colors.black12 :Colors.white ,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, left: 20, right: 20, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Assalaamu'alaikum",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Muhammad Zaim Maulana",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: ApiService.getSuratFromAPI(),
                        builder: (context,
                            AsyncSnapshot<List<SuratModel>> snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, i) {
                                  return Card(
                                      shadowColor: HexColor("#B068D0"),
                                      elevation: 2,
                                      child: ListTile(
                                        leading: Text(
                                          "(" +
                                              snapshot.data![i].nomor
                                                  .toString() +
                                              ")",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: HexColor("#B068D0")),
                                        ),
                                        title: Text(
                                          snapshot.data![i].nama,
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w700),
                                        ),
                                        subtitle: Text(
                                          snapshot.data![i].arti,
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: HexColor("#B068D0")),
                                        ),
                                        trailing: Text(
                                          snapshot.data![i].asma,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailSurat(
                                                        nomor: snapshot
                                                            .data![i].nomor,
                                                        namaSurat: snapshot
                                                            .data![i].nama,
                                                        asmaSurat: snapshot
                                                            .data![i].asma,
                                                        artiSurat: snapshot
                                                            .data![i].arti,
                                                      )));
                                        },
                                      ));
                                });
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
          drawer: DrawerScreen(),
        );
      },
    );
  }
}
