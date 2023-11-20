import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cities {
  late String city;
  late String province;

  Cities(this.city, this.province);

  Cities.fromJson(json) {
    city = json['name'];
    province = json['province'];
  }
}

List data = [];

Future<List<Cities>> getCities() async {
  data = await readJson();
  return data.map<Cities>(Cities.fromJson).toList();
}

Future<List<dynamic>> readJson() async {
  final String response =
      await rootBundle.loadString('assets/data/philippine_cities.json');
  final decodedJson = await json.decode(response);
  debugPrint('${decodedJson[1]}');
  return decodedJson;
}
