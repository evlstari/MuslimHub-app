import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

import '../../Models/locationHelper.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lokasi")),
      body: FutureBuilder(
          future: LocationHelper.getDataLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // cek apakah future seelsai apa tidak
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "${snapshot.error}",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              } else if (snapshot.hasData) {
                // ekstrak data dari objek snapshot.
                LocationData? data = snapshot.data;
                // dapatkan data lat dan long kemudian simpan dalam variabel
                double? lat = data?.latitude;
                double? long = data?.longitude;
                return FlutterMap(
                  options: MapOptions(
                    center: LatLng(lat!, long!),
                    zoom: 17.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) {
                        return Text("© OpenStreetMap contributors");
                      },
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(lat, long),
                          builder: (ctx) => Icon(
                            Icons.location_on,
                            size: 45,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }
            // menampilkan loading spinner
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
