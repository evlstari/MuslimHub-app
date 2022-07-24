import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:project_flutter/View/Login.dart';
import 'package:project_flutter/View/page/HadistScreen.dart';
import 'package:project_flutter/View/page/locatinscreen.dart';
import 'package:project_flutter/view/page/dzikirscreen.dart';
import 'package:project_flutter/view/page/settings.dart';

import '../Models/locationHelper.dart';


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Widget Avatar/ profile
  Widget? imageProfile(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile == null
                ? AssetImage('assets/img/zaim.jpg')
                : FileImage(File(_imageFile!.path)) as ImageProvider,
          ),
          Positioned(
              bottom: 0.0,
              right: 0.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (builder) => bottomSheet(context)!);
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 24.0,
                ),
              )),
        ],
      ),
    );
  }

  // Bottom Modal
  Widget? bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        takePhoto(ImageSource.camera);
                      },
                      icon: Icon(Icons.camera)),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Camera")
                ],
              ),
              SizedBox(
                width: 16,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        takePhoto(ImageSource.gallery);
                      },
                      icon: Icon(Icons.image)),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Gallery")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  // Mengakses / pick image dari source (Kamera/galer)
  void takePhoto(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  // Method untuk memperoleh alamat dari data lokasi
  Future<String> _ambilAlamat(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    return "${placemarks.last.street}, ${placemarks.reversed.last.locality} ";
  }

  // Method untuk ambil lokasi kemudian dari lokasi tersebut didapatkan alamatnya
  Future<String> ambilData() async {
    // Buat variabel yang digunakan untuk menyimpan data lat dan  long
    double? lat;
    double? long;
    // Ambil data lokasi

    await LocationHelper.getDataLocation().then((value) {
      LocationData? lokasi = value;
      lat = lokasi?.latitude;
      long = lokasi?.longitude;
    });

    return _ambilAlamat(lat!, long!);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Muhammad Zaim Maulana"),
            currentAccountPicture: imageProfile(context),
            accountEmail: FutureBuilder(
              future: ambilData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // Cek apakah future selesai apa tidak
                if (snapshot.connectionState == ConnectionState.done) {
                  // Jika terdapat error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "${snapshot.error} occured",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    // Ekstrak data dari objek snapshot dan tampilkan ke widget text.
                    final data = snapshot.data as String;
                    return Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          data,
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    );
                  }
                }
                // Menampilkan animasi loading spinner yang menandakan bahwa
                // state menunggu (waiting).
                return Text("Find Location...");
              },
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/quran.svg',
              color: Colors.grey,
            ),
            title: Text(
              "Quran Surat",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerListTile(
            iconData: Icon(Icons.book),
            title: Text(
              "Daftar Hadist",
              style: TextStyle(fontSize: 16),
            ),
            onTilePressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HadistScreen()));
            },
          ),
          DrawerListTile(
            iconData: Icon(Icons.timer),
            title: Text(
              "Dzikir",
              style: TextStyle(fontSize: 16),
            ),
            onTilePressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DzikirScreen()));
            },
          ),
          DrawerListTile(
            iconData: Icon(Icons.location_history),
            title: Text(
              "Lokasi",
              style: TextStyle(fontSize: 16),
            ),
            onTilePressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LocationScreen()));
            },
          ),
          DrawerListTile(
            iconData: Icon(Icons.settings),
            title: Text(
              "Settings",
              style: TextStyle(fontSize: 16),
            ),
            onTilePressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
          DrawerListTile(
            iconData: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              "Log out",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            onTilePressed: () {
              _signOut().then((value) => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen())));
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final Icon? iconData;
  final Text? title;
  final VoidCallback? onTilePressed;

  const DrawerListTile(
      {Key? key, this.iconData, this.title, this.onTilePressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: iconData,
      title: title,
    );
  }
}
