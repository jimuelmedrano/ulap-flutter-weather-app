import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ulap_flutter_weather_app/data/cities_model.dart';
import 'package:ulap_flutter_weather_app/data/geolocator.dart';
import 'package:ulap_flutter_weather_app/data/weather_api.dart';
import 'package:ulap_flutter_weather_app/data/weather_icons.dart';
import 'package:ulap_flutter_weather_app/utils/time_util.dart';
import 'package:ulap_flutter_weather_app/widgets/forecast_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ulap_flutter_weather_app/widgets/location_widget.dart';

String city = '';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String cityName = '';
  //final test = getAddress();
  final String? apiKey = dotenv.env['API_KEY'];
  late List<Cities> listCities;

  Future refresh() async {
    setState(() {});
  }

  Future getCity() async {
    if (city.isNotEmpty) {
      return [Placemark(locality: city)];
    } else {
      return await getAddress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getCity(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final addressData = snapshot.data;
          if (addressData != null && addressData[0].locality != '') {
            city = addressData[0].locality;
          } else {
            // Default City
            city = 'Manila';
          }
          return RefreshIndicator(
            onRefresh: refresh,
            child: Center(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: FutureBuilder(
                  future: Future.wait([
                    getCurrentWeather(city, apiKey),
                    getWeatherForecast(city, apiKey),
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
                        child: Column(
                          children: [
                            const Text(
                              'Error occured.\nPlease try again later or check your internet connection.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                                onPressed: refresh, child: const Text('Retry'))
                          ],
                        ),
                      );
                    }

                    // this data is returned from getCurrentWeather()
                    final data = snapshot.data!;

                    final currentTemp = data[0]['main']['temp'];
                    final currentWeather = data[0]['weather'][0]['main'];
                    final currentWeatherDesc =
                        data[0]['weather'][0]['description'];
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
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      final cityNameSearch = await openDialog();
                                      if (cityNameSearch != null) {
                                        setState(() {
                                          city = cityNameSearch;
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          city,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Icon(Icons.location_on),
                                      ],
                                    ),
                                  ),
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
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i <= 7; i++)
                                  ForecastWidget(
                                    data: data[1]['list'][i],
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Additional Information',
                            style: TextStyle(fontSize: 20),
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
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
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
            content: FutureBuilder(
                future: getCities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  final cityData = snapshot.data!;
                  return LocationWidget(listCities: cityData, submit: submit);
                })),
      );

  void submit(String city) {
    if (city.isEmpty) {
      Navigator.of(context).pop();
    } else if (city == 'current') {
      Navigator.of(context).pop('');
    } else {
      Navigator.of(context).pop(city);
    }
  }
}
