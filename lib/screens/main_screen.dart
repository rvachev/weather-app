import 'package:flutter/material.dart';
import 'package:weather_app/screens/today_weather.dart';
import 'package:weather_app/screens/weather_forecast.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = TextEditingController();

  String city = 'Омск';
  bool isSearching = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: isSearching
                ? TextField(
                    controller: _controller,
                    onSubmitted: (text) => setState(() {
                      city = _controller.text;
                      isSearching = false;
                    }),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Введите город'),
                  )
                : Text(city),
            centerTitle: true,
            actions: isSearching
                ? [
                    IconButton(
                        icon: Icon(Icons.done),
                        onPressed: () => setState(() {
                              city = _controller.text;
                              isSearching = false;
                            })),
                    IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () => setState(() {
                              isSearching = false;
                            }))
                  ]
                : [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => setState(() {
                              isSearching = true;
                            }))
                  ],
            bottom: TabBar(tabs: [
              Tab(
                text: 'Сегодня',
              ),
              Tab(
                text: '3 дня',
              )
            ]),
          ),
          body: TabBarView(
            children: [TodayWeather(city: city), WeatherForecast(city: city)],
          )),
    );
  }
}
