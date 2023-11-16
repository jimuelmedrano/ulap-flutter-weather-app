import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForecastWidget extends StatelessWidget {
  final String hour;
  final String weatherIcon;
  final String temp;
  const ForecastWidget(
      {super.key,
      required this.hour,
      required this.weatherIcon,
      required this.temp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 120,
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
            Text(hour),
            SvgPicture.asset(
              weatherIcon,
              width: 50,
              height: 50,
            ),
            Text(temp),
          ],
        ),
      ),
    );
  }
}
