import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class AppApi {
  Future<Response> currentWeatherData(String city) async {
    final queryParameters = {
      "q": city,
      "appid": "3126d240838b61e3fa8df235412f9b6c",
      "units": "metric",
    };
    final uri = Uri.https(
        "api.openweathermap.org", "/data/2.5/weather", queryParameters);

    final response = await http.get(uri);
    final data = Response.fromJson(jsonDecode(response.body));
    return data;
  }
}
