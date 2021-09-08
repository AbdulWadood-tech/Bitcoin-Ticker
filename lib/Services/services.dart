import 'dart:convert';
import 'package:cryptocurrencies/Model/coins_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Services {
  String coinName;
  String currencyName;
  Services({required this.coinName, required this.currencyName});
  String apiKey = '06E0FE84-9EFF-430F-9C11-DAF7A0016440';

  Future<CoinModel> getCoinsRate() async {
    var url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$coinName/$currencyName?apikey=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('data has been fetched');
      print(response.statusCode);
      String data = response.body;
      var decodedData = jsonDecode(data);
      var cName = decodedData["asset_id_base"];
      var cuName = decodedData["asset_id_quote"];
      var price = decodedData["rate"];
      print(cName);
      print(cuName);
      print(price);
      CoinModel model =
          CoinModel(currencyName: cuName, coinName: cName, price: price);
      return model;
    } else {
      print('There is an error');
      var code = response.statusCode;
      print(code);
      CoinModel model =
          CoinModel(currencyName: '$code', coinName: '', price: 0.0);
      return model;
    }
  }
}
