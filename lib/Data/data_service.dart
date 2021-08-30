import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uv_index/Utilities/models.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    //api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    final queryParameters = {
      'q': city,
      'appid': '21d54d5a2a58c1b9483274bac539182d'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
