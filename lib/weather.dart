import 'dart:convert';

import 'package:http/http.dart';

class Weathaer {
  num? temp; //気温
  num? tempMax; //最高気温
  num? tempMin; //最低気温
  String? description; //天気状態
  num? lon; //経度
  num? lat; //緯度
  String? icon; //天気情報のアイコン
  DateTime? time; //日時
  num? rainyPercent; //降水確率

  Weathaer(
      {this.temp,
      this.tempMax,
      this.tempMin,
      this.description,
      this.lon,
      this.lat,
      this.icon,
      this.time,
      this.rainyPercent});

  static String publicParameter =
      '&appid=2b3b21ceb14613a16e8925665955a657&lang=ja&units=metric';
  //apiidから後ろは自分のapiサイトのkye(不変)だから見やすくするために変数にまとめた。
  static Future<Weathaer?> getCurrentWeather(String zipCode) async {
    String _zipCode;
    if (zipCode.contains('-')) {
      _zipCode = zipCode;
    } else {
      _zipCode = zipCode.substring(0, 3) + '-' + zipCode.substring(3);

      ///.substring(0,3)でzipCode(郵便番号)でとってきた値の0番目～2番目すなわち1～3文字目までを表す
      ///substring(3)は３番目以降をとってくる(0034)。substring()は取ってくる初めの数字は絶対で、終わりの数字を入れなけらばそれ以降全部ということになる
      ///zipCode.substring(0,2)+ '-'+ zipCode.substring(3);は341-0034
    }
    String url =
        'https://api.openweathermap.org/data/2.5/weather?zip=$_zipCode,JP$publicParameter';
    try {
      var result = await get(Uri.parse(url)); //resultにapiのコードをいれこんで使っている
      Map<String, dynamic> data = jsonDecode(result.body);
      Weathaer currentWeather = Weathaer(
        description: data['weather'][0]['description'],
        temp: data['main']['temp'],
        tempMax: data['main']['temp_max'],
        tempMin: data['main']['temp_min'],
        lon: data['coord']['lon'],
        lat: data['coord']['lat'],
      );
      print(data);
      return currentWeather;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, List<Weathaer>>?> getForecast(
      {num? lon, num? lat}) async {
    Map<String, List<Weathaer>>? response = {};

    String url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely$publicParameter';
    try {
      var result = await get(Uri.parse(url)); //resultにapiのコードをいれこんで使っている
      Map<String, dynamic> data = jsonDecode(result.body);
      List<dynamic> hourlyWeatherData = data['hourly'];
      List<dynamic> dailyWeatherData = data['daily'];
      print(dailyWeatherData);

      List<Weathaer> hourlyWeather = hourlyWeatherData.map((wea) {
        return Weathaer(
          time: DateTime.fromMillisecondsSinceEpoch(wea['dt'] * 1000),
          temp: wea['temp'],
          icon: wea['weather'][0]['icon'],
        );
      }).toList();
      List<Weathaer> dailyWeather = dailyWeatherData.map((day) {
        return Weathaer(
          time: DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000),
          icon: day['weather'][0]['icon'],
          tempMax: day['temp']['max'],
          tempMin: day['temp']['min'],
          rainyPercent: day.containsKey('rain') ? day['rain'] : 0,
        );
      }).toList();
      print(dailyWeather[0].time);
      print(dailyWeather[0].icon);
      print(dailyWeather[0].tempMax);
      print(dailyWeather[0].tempMin);
      print(dailyWeather[0].rainyPercent);
      response['hourly'] = hourlyWeather;
      response['daily'] = dailyWeather;

      print(hourlyWeather[0].time);
      print(hourlyWeather[0].temp);
      print(hourlyWeather[0].icon);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
