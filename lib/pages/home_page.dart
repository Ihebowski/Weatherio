import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:weather_app/constants/app_colors.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/app_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Response> currentWeather;
  bool isNight = false;

  @override
  void initState() {
    super.initState();
    currentWeather = AppApi().currentWeatherData("New York");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: FutureBuilder(
        future: currentWeather,
        builder: (context, AsyncSnapshot<Response> snapshot) {
          if (!snapshot.hasData) {
            print("failed");
            return Text("Error");
          } else {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Text(
                    snapshot.data!.name!.toUpperCase(),
                    style: const TextStyle(
                      letterSpacing: 2,
                      color: primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    StringUtils.capitalize(
                      snapshot.data!.weather![0].description,
                      allWords: true,
                    ),
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    "assets/icons/${snapshot.data!.weather![0].icon}.png",
                    height: 200,
                    width: 200,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${snapshot.data!.main!.temp!.toInt()}°C",
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 120,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff303052),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        detailText("Wind",
                            snapshot.data!.wind!.speed.toString(), "Km/h"),
                        detailText("Pressure",
                            snapshot.data!.main!.pressure.toString(), "hPa"),
                        detailText("Humidity",
                            snapshot.data!.main!.humidity.toString(), "%"),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Widget detailText(String title, String value, String mesure) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(height: 5),
      RichText(
        text: TextSpan(
          style: const TextStyle(
            color: primaryColor,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: " $mesure",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      )
    ],
  );
}
