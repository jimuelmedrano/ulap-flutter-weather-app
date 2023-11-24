import 'package:flutter/material.dart';
import 'package:ulap_flutter_weather_app/data/cities_model.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget(
      {Key? key, required this.listCities, required this.submit})
      : super(key: key);
  final List<Cities> listCities;
  final ValueChanged<String> submit;
  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  late TextEditingController controller;
  late List<Cities> cityStateList;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    cityStateList = widget.listCities;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Set Location',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  widget.submit('');
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
          const SizedBox(height: 15),
          TextField(
            controller: controller,
            onChanged: searchFilter,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'City/Municipality',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(color: Theme.of(context).hintColor, width: 1),
                )),
          ),
          TextButton(
            onPressed: () {
              widget.submit('current');
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on),
                Text(
                  'Use Current Location',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.white,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(
              width: 500,
              height: 350,
              child: ListView.builder(
                  itemCount: cityStateList.length,
                  itemBuilder: (context, index) {
                    final cityData = cityStateList[index];
                    return ListTile(
                      leading: const Icon(Icons.location_city),
                      title: Text('${cityData.city}, ${cityData.province}'),
                      onTap: () {
                        controller.text = cityData.city;
                        widget.submit(controller.text);
                        controller.clear();
                      },
                    );
                  }))
        ],
      ),
    );
  }

  void searchFilter(String query) {
    final suggestions = widget.listCities.where((element) {
      final cityName =
          '${element.city.toLowerCase()}, ${element.province.toLowerCase()}';
      final input = query.toLowerCase();

      return cityName.contains(input);
    }).toList();

    setState(() {
      cityStateList = suggestions;
    });
  }
}
