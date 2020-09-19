import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../modals/prayer.dart';

class Pray with ChangeNotifier {
  List<Prayer> _items = [];

  List<Prayer> get items {
    return [..._items];
  }

  Future<void> fetchAndSet(String day, String city) async {
    // String day = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

    final url = 'https://api.pray.zone/v2/times/day.json?city=$city&date=$day';
    try {
      final response = await http.get(url);

      final extractData = json.decode(response.body) as Map<String, dynamic>;
      final List<Prayer> loadedPray = [];
      if (extractData == null) {
        return;
      }
      loadedPray.add(
        Prayer(
          id: DateTime.now().toString(),
          times: extractData['results']['datetime'][0]['times'],
          location: extractData['results']['location'],
          date: extractData['results']['datetime'][0]['date'],
        ),
      );
      _items = loadedPray;

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
