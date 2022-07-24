import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_flutter/Models/Hadist.dart';
import 'package:project_flutter/Models/Surat.dart';

class ApiService{
  static Future<List<SuratModel>> getSuratFromAPI() async{
    var response = await http
        .get(Uri.parse("https://api.banghasan.com/quran/format/json/surat"));
    List<dynamic> jsonData =
        jsonDecode(utf8.decode(response.bodyBytes))['hasil'];

    List<SuratModel> users = [];

    for (var i = 0; i < jsonData.length; i++) {
      users.add(SuratModel.fromJson(jsonData[i]));
    }
    return users;

    // String apiURL = 'https://api.banghasan.com/quran/format/json/surat';
    // var apiResult = await http.get(Uri.parse(apiURL));
    // var jsonObject = jsonDecode(apiResult.body);
    // List<dynamic> listSurat = jsonObject['hasil'];

    // List<SuratModel> list = [];
    // for (var i = 0; i < listSurat.length; i++) {
    //   list.add(SuratModel.fromJson(listSurat[i]));
    // }
    // print(list.length);
    // return list;
  } 

  static Future<List<SuratModel>> getAyatData(String? nomor) async{
    
    var response = await http.get(Uri.parse(
      "https://api.banghasan.com/quran/format/json/surat/"+nomor!+"/ayat/1-10"));
    List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes))['ayat']['data']['ar'];

    List<SuratModel> users = [];

    for (var i = 0; i < jsonData.length; i++) {
      users.add(SuratModel.fromJson(jsonData[i]));
    }
    return users;
  }

  static Future<List<HadistModel>> getHadistData() async{
    var response = await http.get(Uri.parse(
      "https://api.hadith.sutanlab.id/books"));
    List<dynamic> jsonData = jsonDecode(response.body)['data'];

    List<HadistModel> hadists = [];

    for (var i = 0; i < jsonData.length; i++) {
      hadists.add(HadistModel.fromJson(jsonData[i]));
    }
    return hadists;
  }

  static Future<List<HadistModel>> getDetailHadist(String? id) async{
    
    var response = await http.get(Uri.parse(
      "https://api.hadith.sutanlab.id/books/"+id!+"?range=1-10"));
    List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes))['data']['hadiths'];

    List<HadistModel> users = [];

    for (var i = 0; i < jsonData.length; i++) {
      users.add(HadistModel.fromJson(jsonData[i]));
    }
    return users;
  }

  
}