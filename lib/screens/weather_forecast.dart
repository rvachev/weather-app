import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/entities/weather.dart';
import 'package:weather_app/utils.dart';

class WeatherForecast extends StatefulWidget {
  final String city;

  const WeatherForecast({@required this.city});

  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchWeatherForecast(widget.city),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<Weather> data = snapshot.data;
          return RefreshIndicator(
            onRefresh: refreshList,
            child: ListView(
              children: getListForecast(data),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<Null> refreshList() async {
    setState(() {});
    return null;
  }

  List<Widget> getListForecast(List<Weather> weatherList) {
    List<Widget> listOfWidgets = [];
    weatherList.forEach((element) {
      listOfWidgets.add(ListTile(
        leading: Text(
          getWeatherString(element.tempreture),
          style: TextStyle(fontSize: 24),
        ),
        title: Text(element.date),
        subtitle: Text('Мин.: ' + getWeatherString(element.minTempreture)),
        trailing: CachedNetworkImage(
          imageUrl: element.iconUrl,
          placeholder: (context, url) => Container(
              height: 64,
              width: 64,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              )),
        ),
      ));
      listOfWidgets.add(Divider());
    });
    return listOfWidgets;
  }
}
