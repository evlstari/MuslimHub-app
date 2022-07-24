import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';


class LocationHelper{

  static Future<LocationData?> getDataLocation() async{
    // Buat dulu objek lokasi
    Location lokasi = await Location();

    bool _layananDiaktifkan;
    bool _isListenLocation=false,_isGetLocation=false;
    PermissionStatus _ijinDiberikan;
    LocationData _dataLokasi;
    String address;

    // Cek apakah GPS diaktifkan atau dimatikan oleh pengguna
    _layananDiaktifkan = await lokasi.serviceEnabled();
    // Jika GPS tidak diaktifkan
    if (!_layananDiaktifkan) {
      // Tampilkan pesan untuk mengaktifkan GPS
      _layananDiaktifkan = await lokasi.requestService();
      // lakukan pengecekan lagi apakah GPS telah aktif
      if (!_layananDiaktifkan) {
        return null;
      }
    }

    // cek apakah diijinkan untuk akses lokasi
    _ijinDiberikan = await lokasi.hasPermission();
    // jika status ditolak
    if (_ijinDiberikan == PermissionStatus.denied) {
      // tampilkan pesan untuk pengaksesan lokasi
      _ijinDiberikan = await lokasi.requestPermission();
      // cek sekali lagi pakah ijin akses diberikan.
      if (_ijinDiberikan != PermissionStatus.granted) {
        return null;
      }
    }

    // Ambil objek data lokasi
    _dataLokasi = await lokasi.getLocation();
    return _dataLokasi;
  }
}