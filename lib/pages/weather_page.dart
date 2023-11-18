import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ulap_flutter_weather_app/data/weather_api.dart';
import 'package:ulap_flutter_weather_app/data/weather_icons.dart';
import 'package:ulap_flutter_weather_app/utils/time_util.dart';
import 'package:ulap_flutter_weather_app/widgets/forecast_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final String cityName = 'Candelaria';
  final String? apiKey = dotenv.env['API_KEY'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: Future.wait([
          getCurrentWeather(cityName, apiKey),
          getWeatherForecast(cityName, apiKey),
        ]),
        builder: (context, snapshot) {
          //if API is still loading, return a circular progress
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          // this data is returned from getCurrentWeather()
          final data = snapshot.data!;

          final currentTemp = data[0]['main']['temp'];
          final currentWeather = data[0]['weather'][0]['main'];
          final currentWeatherDesc = data[0]['weather'][0]['description'];
          final currentHumidity = data[0]['main']['humidity'];
          final currentWindSpeed = data[0]['wind']['speed'];
          final sunriseEpoch = data[0]['sys']['sunrise'];
          final sunsetEpoch = data[0]['sys']['sunset'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cityName,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Icon(Icons.location_on),
                      ],
                    ),
                    const SizedBox(height: 5),
                    SvgPicture.asset(
                      getWeatherIcon(currentWeather),
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      '$currentTemp°C',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(currentWeatherDesc),
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
                      for (int i = 0; i <= 7; i++)
                        ForecastWidget(
                          hour: getTimeFromTimestamp(
                              data[1]['list'][i]['dt_txt']),
                          weatherIcon: getWeatherIcon(
                              data[1]['list'][i]['weather'][0]['main']),
                          temp: '${data[1]['list'][i]['main']['temp']}°C',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        const Icon(
                          Icons.water_drop,
                          size: 40,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Humidity',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '$currentHumidity%',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        const Icon(
                          Icons.air,
                          size: 40,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Wind Speed',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '$currentWindSpeed m/s',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        const Icon(
                          Icons.sunny,
                          size: 40,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Sunrise',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          getTimeFromEpoch(sunriseEpoch),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        const Icon(
                          Icons.sunny_snowing,
                          size: 40,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Sunset',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          getTimeFromEpoch(sunsetEpoch),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
