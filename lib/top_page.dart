import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_api_st/weather.dart';
import 'package:lab_api_st/zip_code.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Weathaer currentWeather =
      Weathaer(temp: 15, description: '晴れ', tempMax: 18, tempMin: 14);
  String address = '-';
  String? errorMessage;
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
  List<Weathaer> dailyWeather = [
    Weathaer(
        tempMax: 20, tempMin: 16, rainyPercent: 0, time: DateTime(2021, 10, 1)),
    Weathaer(
        tempMax: 18, tempMin: 15, rainyPercent: 0, time: DateTime(2021, 10, 2)),
    Weathaer(
        tempMax: 20, tempMin: 19, rainyPercent: 0, time: DateTime(2021, 10, 3)),
    Weathaer(
        tempMax: 20, tempMin: 16, rainyPercent: 0, time: DateTime(2021, 10, 1)),
    Weathaer(
        tempMax: 18, tempMin: 15, rainyPercent: 0, time: DateTime(2021, 10, 2)),
    Weathaer(
        tempMax: 20, tempMin: 19, rainyPercent: 0, time: DateTime(2021, 10, 3)),
    Weathaer(
        tempMax: 20, tempMin: 16, rainyPercent: 0, time: DateTime(2021, 10, 1)),
    Weathaer(
        tempMax: 18, tempMin: 15, rainyPercent: 0, time: DateTime(2021, 10, 2)),
    Weathaer(
        tempMax: 20, tempMin: 19, rainyPercent: 0, time: DateTime(2021, 10, 3)),
    Weathaer(
        tempMax: 20, tempMin: 16, rainyPercent: 0, time: DateTime(2021, 10, 1)),
    Weathaer(
        tempMax: 18, tempMin: 15, rainyPercent: 0, time: DateTime(2021, 10, 2)),
    Weathaer(
        tempMax: 20, tempMin: 19, rainyPercent: 0, time: DateTime(2021, 10, 3)),
    Weathaer(
        tempMax: 20, tempMin: 16, rainyPercent: 0, time: DateTime(2021, 10, 1)),
    Weathaer(
        tempMax: 18, tempMin: 15, rainyPercent: 0, time: DateTime(2021, 10, 2)),
    Weathaer(
        tempMax: 20, tempMin: 19, rainyPercent: 0, time: DateTime(2021, 10, 3)),
    Weathaer(
        tempMax: 20, tempMin: 16, rainyPercent: 0, time: DateTime(2021, 10, 1)),
    Weathaer(
        tempMax: 18, tempMin: 15, rainyPercent: 0, time: DateTime(2021, 10, 2)),
    Weathaer(
        tempMax: 20, tempMin: 19, rainyPercent: 0, time: DateTime(2021, 10, 3)),
  ];
  List<String> weekDay = ['月', '火', '水', '木', '金', '土', '日'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
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
              }

              ///searchAddressFromZipCodeでasync/awaitを使っているからこっちでもasync/awaitを使ってあげる
              print(address);
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
        SingleChildScrollView(
          //wodgetをスクロール可能にする
          scrollDirection: Axis
              .horizontal, //SingleChildScrollViewは縦方向のスクロールがデフォルトだからこれで横方向に適応させる。

          child: Row(
            children: hourlyWeather.map((weatherPre) {
              ///mapの書き方　チャプター5　8:00　weatherPreの所はなんでもいい
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  children: [
                    Text(
                        '${DateFormat('H').format(weatherPre.time!)}時'), //hourlyWeather[0].0を書く事でリストの一番最初のモノを取得出来る
                    Text(
                      '${weatherPre.rainyPercent}%',
                      style: const TextStyle(color: Colors.lightBlueAccent),
                    ),
                    const Icon(Icons.wb_sunny_sharp),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${weatherPre.temp}',
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
        Expanded(
          //適応範囲を限定できる（SingleChildScrollViewを使うときにエラーが出たら使うぐらいで覚えとけばいい、とりあえず）
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: dailyWeather.map((we) {
                  return Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 50,
                            child: Text('${weekDay[we.time!.weekday - 1]}曜日')),
                        Row(
                          children: [
                            const Icon(Icons.wb_sunny_sharp),
                            Text(
                              '${we.rainyPercent}%',
                              style: const TextStyle(
                                  color: Colors.lightBlueAccent),
                            ),
                          ],
                        ),
                        Container(
                          width: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${we.tempMax}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${we.tempMin}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
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
    )));
  }
}
