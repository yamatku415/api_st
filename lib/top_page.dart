import 'package:flutter/material.dart';
import 'package:lab_api_st/weather.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Weathaer currentWeather =
      Weathaer(temp: 15, description: '晴れ', tempMax: 18, tempMin: 14);
  List<Weathaer> hourlyWeather = [
    //List<Weathaer>とする事で、Weathaerクラスで定義した変数を使うことができる。
    Weathaer(
        temp: 20,
        description: '晴れ',
        time: DateTime(2021, 10, 1, 10),
        rainyPercent: 0),
    Weathaer(
        temp: 18,
        description: '雨',
        time: DateTime(2021, 10, 1, 11),
        rainyPercent: 0),
    Weathaer(
        temp: 17,
        description: '曇り',
        time: DateTime(2021, 10, 1, 12),
        rainyPercent: 0),
    Weathaer(
        temp: 19,
        description: '晴れ',
        time: DateTime(2021, 10, 1, 13),
        rainyPercent: 10),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        const Text(
          '大阪市',
          style: TextStyle(fontSize: 25),
        ),
        Text(currentWeather.description ?? ''),
        Text(
          '${currentWeather.temp}°',
          style: const TextStyle(fontSize: 80),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('最高:${currentWeather.tempMax}°'),
            ),
            Text('最低:${currentWeather.tempMin}°'),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        const Divider(
          height: 0,
        ),
        Row(
          children: [],
        ),
        const Divider(
          height: 0,
        ),
      ],
    )));
  }
}
