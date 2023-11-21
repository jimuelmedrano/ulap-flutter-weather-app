import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map<String, dynamic>> getCurrentWeather(cityName, apiKey) async {
  try {
    final result = await http.get(
      Uri.parse(
          '${dotenv.env['API_BASE_URL']}/data/2.5/weather?q=$cityName,ph&units=metric&APPID=$apiKey'),
    );
    final data = jsonDecode(result.body);

    if (data['cod'].toString() != '200') {
      throw data['message'];
    }

    return data;
  } catch (e) {
    throw e.toString();
  }
}

Future<Map<String, dynamic>> getWeatherForecast(cityName, apiKey) async {
  try {
    final result = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,ph&units=metric&APPID=$apiKey'),
    );
    final data = jsonDecode(result.body);

    if (data['cod'].toString() != '200') {
      throw data['message'];
    }

    return data;
  } catch (e) {
    throw e.toString();
  }
}
