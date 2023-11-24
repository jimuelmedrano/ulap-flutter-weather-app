import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ulap_flutter_weather_app/data/weather_icons.dart';
import 'package:ulap_flutter_weather_app/utils/time_util.dart';

class ForecastWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  const ForecastWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 120,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              content: SizedBox(
                width: 500,
                height: 340,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Forecast Details',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text(
                            'x ',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        SvgPicture.asset(
                          getWeatherIcon(data['weather'][0]['main']),
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          '${data['main']['temp']}°C',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('${data['weather'][0]['description']}'),
                        const SizedBox(height: 10),
                        Text(
                          getFormattedTimeFromTimestamp(data['dt_txt']),
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
                                  '${data['main']['humidity']}%',
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
                                  '${data['wind']['speed']} m/s',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Theme.of(context).hintColor, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(getTimeFromTimestamp(data['dt_txt'])),
              SvgPicture.asset(
                getWeatherIcon(data['weather'][0]['main']),
                width: 50,
                height: 50,
              ),
              Text('${data['main']['temp']}°C'),
            ],
          ),
        ),
      ),
    );
  }
}
