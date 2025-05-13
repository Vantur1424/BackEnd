// ignore_for_file: body_might_complete_normally_nullable, unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dbHelper.dart';
import 'model/kopi.dart';
import 'package:http/http.dart' as http;

class ScreenPageProvider extends ChangeNotifier {
  final DBHelper _dbHelper = DBHelper.instance;
  List<Coffe> _coffe = [];
 

  List<Coffe> get coffe => _coffe;
  bool isSearching = false;
  
  

  Future<List<Coffe>?> initializeCoffe() async {
    final dbHelper = DBHelper.instance;

    try {
      final coffeData = await getCoffeData();
      if (coffeData != null && coffeData.isNotEmpty) {
      } else {
        print("Error: Data kosong atau tidak valid");
        return null;
      }

      for (final coffeMap in coffeData) {
        final coffe = Coffe(
          nama: coffeMap['nama'],
          img: coffeMap['img'],
          harga: coffeMap['harga'],
          rate: coffeMap['rating'],
          desk: coffeMap['deskripsi'],
        );

        final existingCoffe = await dbHelper.getCoffeByName(coffe.nama);

        if (existingCoffe == null) {
          await dbHelper.insertCoffe(coffe);
        } else {
          await dbHelper.updateCoffe(coffe);
        }
      }
      final coffe = await dbHelper.getCoffe();
      _coffe = coffe;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getCoffeData() async {
    final res = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/baskom123/Resources/main/coffe.json"));

    if (res.statusCode == 200) {
      print('Data: ${res.body}');
      final decodeData = json.decode(res.body);

      if (decodeData is Map<String, dynamic> &&
          decodeData.containsKey('data')) {
        final coffeData = decodeData["data"];

        if (coffeData is List &&
            coffeData.isNotEmpty &&
            coffeData[0] is Map<String, dynamic>) {
          return List<Map<String, dynamic>>.from(coffeData);
        }
      }
      throw Exception("Gagal mengambil data: Format data tidak sesuai");
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  List<Coffe> searchResult = [];

  void searchCoffes(String query) {
    searchResult.clear();
    // ignore: unnecessary_null_comparison
    if (coffe != null && coffe.isNotEmpty) {
      for (final coffe in coffe) {
        if (coffe.nama.toLowerCase().contains(query.toLowerCase())) {
          searchResult.add(coffe);
        }
      }
    }
    notifyListeners();
  }

  void clearCoffe() {
    searchResult.clear();
    notifyListeners();
  }

  DateTime date = DateTime.now();
  bool isDataSet = false;
}
