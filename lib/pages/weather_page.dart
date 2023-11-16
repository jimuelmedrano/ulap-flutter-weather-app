import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ulap_flutter_weather_app/data/weather_icons.dart';
import 'package:ulap_flutter_weather_app/widgets/forecast_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Candelaria, PH ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Icon(Icons.location_on),
                  ],
                ),
                SvgPicture.asset(
                  getWeatherIcon('Clear'),
                  width: 150,
                  height: 150,
                ),
                const Text(
                  '25°C',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                const Text('Clear Sky'),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Weather Forecast',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ForecastWidget(
                    hour: '09:00',
                    weatherIcon: getWeatherIcon('Clouds'),
                    temp: '27.34°C',
                  ),
                  ForecastWidget(
                    hour: '10:00',
                    weatherIcon: getWeatherIcon('Drizzle'),
                    temp: '22.3°C',
                  ),
                  ForecastWidget(
                    hour: '11:00',
                    weatherIcon: getWeatherIcon('Rain'),
                    temp: '24.9°C',
                  ),
                  ForecastWidget(
                    hour: '12:00',
                    weatherIcon: getWeatherIcon('Thunderstorm'),
                    temp: '22.2°C',
                  ),
                  ForecastWidget(
                    hour: '13:00',
                    weatherIcon: getWeatherIcon('others'),
                    temp: '27.34°C',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Additional Information',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(height: 5),
                    Icon(
                      Icons.water_drop,
                      size: 40,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Humidity',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '90',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 5),
                    Icon(
                      Icons.air,
                      size: 40,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Wind Speed',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '4.5',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 5),
                    Icon(
                      Icons.beach_access,
                      size: 40,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Pressure',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '34',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
