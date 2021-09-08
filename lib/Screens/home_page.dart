import 'package:cryptocurrencies/Model/coins_model.dart';
import 'package:cryptocurrencies/Services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? nameBTC;
  String? nameETH;
  String? currencyName;
  String userProvideCuName = 'USD';
  double? priceBTC;
  double? priceETH;
  bool check = false;
  List<String> currenciesList = [
    'AUD',
    'BRL',
    'CAD',
    'CNY',
    'EUR',
    'GBP',
    'HKD',
    'IDR',
    'ILS',
    'INR',
    'JPY',
    'MXN',
    'NOK',
    'NZD',
    'PLN',
    'RON',
    'RUB',
    'SEK',
    'SGD',
    'USD',
    'ZAR',
  ];
  var selectedCurrency = 'USD';
  void getBTCData() async {
    Services services =
        Services(coinName: 'BTC', currencyName: userProvideCuName);
    CoinModel model = await services.getCoinsRate();
    nameBTC = model.coinName;
    currencyName = model.currencyName;
    priceBTC = model.price.roundToDouble();
    setState(() {
      check = true;
    });
  }

  void getETHData() async {
    Services services =
        Services(coinName: 'ETH', currencyName: userProvideCuName);
    CoinModel model = await services.getCoinsRate();
    nameETH = model.coinName;
    currencyName = model.currencyName;
    priceETH = model.price.roundToDouble();
    check = true;
  }

  @override
  void initState() {
    super.initState();
    getBTCData();
    getETHData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Currencies prices'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue[600],
              ),
              child: Text(
                check
                    ? 'The price of $nameBTC in $currencyName is $priceBTC'
                    : 'Loading',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue[600],
              ),
              child: Text(
                check
                    ? 'The price of $nameETH in $currencyName is $priceETH'
                    : 'Loading',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xff00A0DC),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xffCFCCCC), width: 2)),
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                  dropdownColor: Color(0xff00A0DC),
                  style: TextStyle(color: Colors.blue),
                  value: selectedCurrency,
                  isDense: true,
                  onChanged: (value) {
                    setState(() {
                      selectedCurrency = value!;
                      userProvideCuName = value!;
                      getBTCData();
                    });
                  },
                  items: currenciesList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
