import 'package:intl/intl.dart';

class Weather {
  final double tempreture;
  final double feelsLike;
  final String description;
  final String iconUrl;
  final double minTempreture;
  final double visibility;
  final int humidity;
  final int cloud;
  final String date;
  final List<Weather>? hourlyForecast;

  Weather(
      {required this.tempreture,
      this.feelsLike = 0.0,
      this.description = '',
      this.minTempreture = 0.0,
      this.date = '',
      this.hourlyForecast,
      this.visibility = 0.0,
      this.humidity = 0,
      this.cloud = 0,
      required this.iconUrl});

  factory Weather.fromJson(Map<String, dynamic> json) {
    List<dynamic> hourlyJson = json['forecast']['forecastday'][0]['hour'];
    List<Weather> hourly = [];
    hourlyJson.forEach((element) {
      hourly.add(Weather(
          tempreture: element['temp_c'],
          iconUrl: 'https:' + element['condition']['icon'],
          date: DateFormat("HH:mm").format(DateTime.parse(element['time']))));
    });
    return Weather(
        tempreture: json['current']['temp_c'],
        feelsLike: json['current']['feelslike_c'],
        description: json['current']['condition']['text'],
        iconUrl: 'https:' + json['current']['condition']['icon'],
        hourlyForecast: hourly,
        visibility: json['current']['vis_km'],
        humidity: json['current']['humidity'],
        cloud: json['current']['cloud']);
  }

  factory Weather.fromJsonForecast(Map<String, dynamic> json) {
    return Weather(
        tempreture: json['day']['maxtemp_c'],
        iconUrl: 'https:' + json['day']['condition']['icon'],
        description: json['day']['condition']['text'],
        minTempreture: json['day']['mintemp_c'],
        date: DateFormat("dd.MM.yyyy").format(DateTime.parse(json['date'])));
  }
}
