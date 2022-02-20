import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/entities/weather.dart';
import 'package:http/http.dart' as http;

String getWeatherString(double weather) {
  if (weather > 0) {
    return '+' + weather.toStringAsFixed(0) + '°';
  }
  return weather.toStringAsFixed(0) + '°';
}

Future<Weather> fetchWeather(String city) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final response =
        await http.get(Uri.https("api.weatherapi.com", "/v1/forecast.json", {
      "key": API_KEY,
      "q": city,
      "days": "3",
      "aqi": "no",
      "lang": "ru",
      "encode": "utf-8"
    }));
    if (response.statusCode == 200) {
      await prefs.setString('jsonCurrent', utf8.decode(response.bodyBytes));
      await prefs.setString('currentCity', city);
      return Weather.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      String jsonBody = prefs.getString('jsonCurrent') ?? '';
      return Weather.fromJson(jsonDecode(jsonBody));
    }
  } catch (exception) {
    String jsonBody = prefs.getString('jsonCurrent') ?? '';
    return Weather.fromJson(jsonDecode(jsonBody));
  }
}

Future<List<Weather>> fetchWeatherForecast(String city) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final response =
        await http.get(Uri.https("api.weatherapi.com", "/v1/forecast.json", {
      "key": API_KEY,
      "q": city,
      "days": "3",
      "aqi": "no",
      "lang": "ru",
      "encode": "utf-8"
    }));
    if (response.statusCode == 200) {
      List<Weather> weatherForecast = [];
      Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
      await prefs.setString('jsonForecast', utf8.decode(response.bodyBytes));
      await prefs.setString('currentCity', city);
      List<dynamic> forecast = json['forecast']['forecastday'];
      forecast.forEach((element) {
        weatherForecast.add(Weather.fromJsonForecast(element));
      });
      return weatherForecast;
    } else {
      List<Weather> weatherForecast = [];
      String jsonBody = prefs.getString('jsonForecast') ?? '';
      List<dynamic> forecast = jsonDecode(jsonBody)['forecast']['forecastday'];
      forecast.forEach((element) {
        weatherForecast.add(Weather.fromJsonForecast(element));
      });
      return weatherForecast;
    }
  } catch (exception) {
    List<Weather> weatherForecast = [];
    String jsonBody = prefs.getString('jsonForecast') ?? '';
    List<dynamic> forecast = jsonDecode(jsonBody)['forecast']['forecastday'];
    forecast.forEach((element) {
      weatherForecast.add(Weather.fromJsonForecast(element));
    });
    return weatherForecast;
  }
}
