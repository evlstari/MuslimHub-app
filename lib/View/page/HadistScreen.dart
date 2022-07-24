import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:project_flutter/Models/Hadist.dart';
import 'package:project_flutter/View/page/DetailHadist.dart';
import 'package:project_flutter/viewModel/api_service.dart';
import 'package:project_flutter/viewModel/helper/theme.dart';
import 'package:provider/provider.dart';

class HadistScreen extends StatefulWidget {
  const HadistScreen({Key? key}) : super(key: key);

  @override
  _HadistScreenState createState() => _HadistScreenState();
}

class _HadistScreenState extends State<HadistScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      ApiService.getHadistData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Daftar Hadist",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                
              ),
              
            ),
            centerTitle: true,
            elevation: 0,
            // backgroundColor: notifier.darkMode ? Colors.black12 :Colors.white,
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon: Icon(
            //     Icons.arrow_back,
            //     color: notifier.darkMode ? Colors.white : Colors.black,
            //   ),
            // ),
          ),
          body: Container(
            // color: notifier.darkMode ? Colors.black12 :Colors.white,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Column(
                  children: [
                    FutureBuilder(
                        future: ApiService.getHadistData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<HadistModel>> snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  int a = index + 1;
                                  return Card(
                                      elevation: 2,
                                      shadowColor: HexColor("#B068D0"),
                                      child: ListTile(
                                        leading: Text(
                                          "(${a++})",
                                          style: TextStyle(
                                            color: HexColor("#B068D0"),
                                          ),
                                        ),
                                        title: Text(
                                          snapshot.data![index].name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailHadist(
                                                        id: snapshot
                                                            .data![index].id,
                                                        name: snapshot
                                                            .data![index].name,
                                                      )));
                                        },
                                      ));
                                });
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
