import 'package:flutter/material.dart';
import 'package:weather_app/entities/weather.dart';
import 'package:weather_app/utils.dart';
import 'package:weather_app/widgets/current_weather_info.dart';

class TodayWeather extends StatelessWidget {
  final String city;

  const TodayWeather({required this.city});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchWeather(city),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          Weather data = snapshot.data;
          return (CurrentWeatherInfo(data: data));
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
