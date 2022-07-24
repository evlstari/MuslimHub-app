import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DzikirScreen extends StatefulWidget {
  const DzikirScreen({Key? key}) : super(key: key);

  @override
  State<DzikirScreen> createState() => _DzikirScreenState();
}

class _DzikirScreenState extends State<DzikirScreen> {
  int counter = 0;

  void ambilCounter() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      // mencoba membaca data counter dan theme shared preference
      // jika counter kosong maka mengembalikan nilai 0
      counter = (prefs.getInt('sp_counter') ?? 0);
    });
  }

  // fungsi untum  menambah counter
  void tambahCounter() async {
    // menggunakan shared preferences
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // ambil data counter dari sharedpreferences,
      // kemudian ubah (update) variabel counter
      // jika data sp_counter kosong, kembalikan nilai 0, kemudian tambah 1.
      counter = (prefs.getInt('sp_counter') ?? 0) + 1;
      // simpan nilai shared preferences baru (update) 'key value'
      prefs.setInt('sp_counter', counter);
    });
  }

  @override
  void initState() {
    super.initState();
    ambilCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dzikir"),
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Reset"),
                        content: Text(
                            "Ingin reset dzikir?"),
                        elevation: 24.0,
                        actions: <Widget>[
                          MaterialButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                counter = 0;
                                prefs.remove('sp_counter');
                              });

                              Navigator.of(context).pop();
                            },
                            color: Colors.white,
                            elevation: 0,
                            child: Text(
                              "Yes",
                              style: TextStyle(color: HexColor("#B068D0")),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              
                            },
                            color: Colors.white,
                            elevation: 0,
                            child: Text(
                              "No",
                              style: TextStyle(color: HexColor("#B068D0")),
                            ),
                          )
                        ],
                      );
                    });
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: MaterialButton(
            onPressed: () {
              tambahCounter();
            },
            shape: CircleBorder(),
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Tap to dzikir",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text("$counter",
                      style: TextStyle(color: Colors.white, fontSize: 48))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
