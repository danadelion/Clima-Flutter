import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'c039c61219523a2733af7cf04309c92a';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
    getData(location.latitude, location.longitude);
  }

  void getData(double latitude, double longitude) async {
    http.Response response = await http.get(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey',
    ); //async metoda, trvá to delší dobu proto je tam async a await
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      String json = response.body;
      dynamic data = jsonDecode(json);
      int condition = data['weather'][0]['id'];
      double temperature = data['main']['temp'];
      String cityName = data['name'];

      print(temperature);
      print(condition);
      print(cityName);
    } else {
      print(response.body);
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
