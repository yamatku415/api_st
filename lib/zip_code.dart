import 'dart:convert';

import 'package:http/http.dart';

class ZipCode {
  static Future<Map<String, String>?> searchAddressFromZipCode(
      String zipCode) async {
    ///Future<String> は何かしらのStringが変ええてくる事を約束しないといけないため、returnを返している。またはFuture<String>に？でnull許容しないとエラーが出る
    String url =
        'https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode'; //zipCodeはとってきた郵便番号を入れる

    try {
      var result = await get(Uri.parse(url));
      Map<String, dynamic> data = jsonDecode(result.body);
      //apiのbodyのデータはmap型になっていて、文字列と様々な型が多在しているからMap<String, dynamic>
      //apiから返ってくる値はjsonなのでそれを変換してあげるjsonDecode(result.body。result.bobyの中に住所などの値が入っている　チャプター9の4:00
      Map<String, String>? response = {};
      if (data['message'] != null) {
        response['message'] = '郵便番号の桁数が不正です';
      } else {
        if (data['results'] == null) {
          response['message'] = '正しい郵便番号を入力してください';
        } else {
          response['address'] = data['results'][0]['address2'];
        }
      }
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
