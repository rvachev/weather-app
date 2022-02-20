import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/entities/weather.dart';
import 'package:weather_app/utils.dart';

class CurrentWeatherInfo extends StatelessWidget {
  const CurrentWeatherInfo({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Weather data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getWeatherString(data.tempreture),
                      style: TextStyle(fontSize: 24.0),
                    ),
                    CachedNetworkImage(
                        imageUrl: data.iconUrl,
                        placeholder: (context, url) => Container(
                            height: 64,
                            width: 64,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ))),
                  ],
                ),
                Text(data.description + ' ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0)),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Container(
                    height: 110,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: getHourlyForecasts(),
                    ),
                  ),
                ),
                Divider(),
                Column(
                  children: [
                    ListTile(
                      subtitle: Text('По ощущению'),
                      title: Text(getWeatherString(data.feelsLike)),
                    ),
                    Divider(),
                    ListTile(
                        subtitle: Text('Влажность'),
                        title: Text(data.humidity.toStringAsFixed(0) + '%')),
                    Divider(),
                    ListTile(
                      subtitle: Text('Видимость'),
                      title: Text(data.visibility.toStringAsFixed(0) + ' км'),
                    ),
                    Divider(),
                    ListTile(
                      subtitle: Text('Облачность'),
                      title: Text(data.cloud.toStringAsFixed(0) + '%'),
                    ),
                    Divider()
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> getHourlyForecasts() {
    List<Widget> hourlyForecast = [];
    data.hourlyForecast?.forEach((element) {
      hourlyForecast.add(Center(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: element.iconUrl,
              placeholder: (context, url) => Container(
                  height: 64,
                  width: 64,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  )),
            ),
            Text(getWeatherString(element.tempreture)),
            Text(
              element.date,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ));
    });
    return hourlyForecast;
  }
}
