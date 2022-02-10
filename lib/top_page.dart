import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_api_st/weather.dart';
import 'package:lab_api_st/zip_code.dart';

import 'app_back_ground.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Weathaer? currentWeather;
  String address = '-';
  String? errorMessage;
  List<Weathaer>? hourlyWeather;
  //List<Weathaer>とする事で、Weathaerクラスで定義した変数を使うことができる。

  List<Weathaer>? dailyWeather;
  List<String> weekDay = ['月', '火', '水', '木', '金', '土', '日'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      AppBackground(),
      Column(
        children: [
          Container(
            width: 200,
            child: TextField(
              onSubmitted: (value) async {
                //TextFieldで打ち込まれた値をvalueに入れて何かの処理に使うことができる。
                print(value);
                Map<String, String>? response = {};
                response = await ZipCode.searchAddressFromZipCode(value);
                errorMessage = response?['message'];
                if (response!.containsKey('address')) {
                  address = response['address'] ?? '';
                  currentWeather = await Weathaer.getCurrentWeather(value);
                  Map<String, List<Weathaer>>? weatherForecast =
                      await Weathaer.getForecast(
                          lon: currentWeather!.lon, lat: currentWeather!.lat);
                  hourlyWeather = weatherForecast?['hourly'];
                  dailyWeather = weatherForecast?['daily'];
                }

                ///searchAddressFromZipCodeでasync/awaitを使っているからこっちでもasync/awaitを使ってあげる
                print(address);
                print(hourlyWeather);

                setState(() {});
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '郵便番号入力'),
            ),
          ),
          Text(
            errorMessage == null ? '' : errorMessage!,
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            address,
            style: const TextStyle(fontSize: 25),
          ),
          Text(
              currentWeather == null ? '-' : currentWeather!.description ?? ''),
          Text(
            currentWeather == null
                ? '-'
                : '${currentWeather!.temp!.toStringAsFixed(0)}°',
            style: const TextStyle(fontSize: 80),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(currentWeather == null
                    ? '最高:-'
                    : '最高:${currentWeather!.tempMax!.toStringAsFixed(0)}°'),
              ),
              Text(currentWeather == null
                  ? '最低:-'
                  : '最低:${currentWeather!.tempMin!.toStringAsFixed(0)}°'),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          const Divider(
            height: 0,
          ),
          SingleChildScrollView(
            //wodgetをスクロール可能にする
            scrollDirection: Axis
                .horizontal, //SingleChildScrollViewは縦方向のスクロールがデフォルトだからこれで横方向に適応させる。

            child: hourlyWeather == null
                ? Container()
                : Row(
                    children: hourlyWeather!.map((weatherPre) {
                      ///mapの書き方　チャプター5　8:00　weatherPreの所はなんでもいい
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                                '${DateFormat('H').format(weatherPre.time!)}時'), //hourlyWeather[0].0を書く事でリストの一番最初のモノを取得出来る

                            Image.network(
                                'http://openweathermap.org/img/wn/${weatherPre.icon}.png'),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${weatherPre.temp!.toStringAsFixed(0)}°',
                                style: const TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
          const Divider(
            height: 0,
          ),
          dailyWeather == null
              ? Container()
              : Expanded(
                  //適応範囲を限定できる（SingleChildScrollViewを使うときにエラーが出たら使うぐらいで覚えとけばいい、とりあえず）
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: dailyWeather!.map((we) {
                          return Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 90,
                                    child: Text(
                                        '${weekDay[we.time!.weekday - 1]}曜日')),
                                Row(
                                  children: [
                                    Image.network(
                                        'http://openweathermap.org/img/wn/${we.icon}.png'),
                                    Container(
                                      width: 50,
                                      child: Text(
                                        '${we.rainyPercent}%',
                                        style: const TextStyle(
                                            color: Colors.blueAccent),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 90,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '↑${we.tempMax!.toStringAsFixed(0)}°',
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.red),
                                      ),
                                      Text(
                                        '↓${we.tempMin!.toStringAsFixed(0)}°',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.blueAccent),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
        ],
      ),
    ])));
  }
}
