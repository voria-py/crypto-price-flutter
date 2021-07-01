import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Shabnam",
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var btcus;
  var ethus;
  var ltcus;
  var trxus;
  var eosus;

  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Future fetchData() async {
    var btcurl = "https://api.cryptonator.com/api/full/btc-usd";
    Response responsebtc = await get(btcurl);
    var databtc = jsonDecode(responsebtc.body);

    var ethurl = "https://api.cryptonator.com/api/full/eth-usd";
    Response responseeth = await get(ethurl);
    var dataeth = jsonDecode(responseeth.body);

    var ltcurl = "https://api.cryptonator.com/api/full/ltc-usd";
    Response responseltc = await get(ltcurl);
    var dataltc = jsonDecode(responseltc.body);

    var trxurl = "https://api.cryptonator.com/api/full/trx-usd";
    Response responsetrx = await get(trxurl);
    var datatrx = jsonDecode(responsetrx.body);

    var eosurl = "https://api.cryptonator.com/api/full/eos-usd";
    Response responseeos = await get(eosurl);
    var dataeos = jsonDecode(responseeos.body);

    setState(() {
      btcus = databtc['ticker']['price'];
      ethus = dataeth['ticker']['price'];
      ltcus = dataltc['ticker']['price'];
      trxus = datatrx['ticker']['price'];
      eosus = dataeos['ticker']['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(19, 22, 27, 100),
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  fetchData();
                });
              },
              child: Icon(
                Icons.refresh,
                semanticLabel: "بروزرسانی",
              ),
            ),
            SizedBox(
              width: 14.00,
            )
          ],
          leading: GestureDetector(
            child: Icon(Icons.info_outline_rounded),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => NetworkGiffyDialog(
                        buttonOkText: Text("وبسایت توسعه دهنده",
                            style: TextStyle(
                                color: Colors.white, fontSize: 11.00)),
                        buttonCancelText: Text("بستن",
                            style: TextStyle(
                                color: Colors.white, fontSize: 11.00)),
                        buttonCancelColor: Colors.black87,
                        buttonOkColor: Colors.black87,
                        onOkButtonPressed: () {},
                        image: Image.asset(
                          "assets/images/cryptobg.jpg",
                          fit: BoxFit.fill,
                        ),
                        entryAnimation: EntryAnimation.TOP_LEFT,
                        title: Text(
                          'توسعه دهنده',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                        description: Text(
                          'امیرحسین خسروی برنامه نویس و توسعه دهنده اپلیکیشن های موبایل و وب | مدرس نرم افزار',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.00),
                        ),
                      ));
            },
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(19, 22, 27, 210),
          elevation: 0.0,
          shadowColor: Color.fromRGBO(19, 22, 27, 210),
          title: Text(
            "آخرین قیمت رمز ارز ها",
            style: TextStyle(fontSize: 12.00, fontWeight: FontWeight.normal),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(30.00),
          child: ListView(
            children: [
              mycryptos(
                cryptoName: "BTC",
                iconUrl: "assets/images/bitcoin-btc-logo.svg",
                priceUs:
                    btcus == null ? "در حال بارگزاری..." : btcus.toString(),
                priceToman: "498,000,000",
              ),
              mycryptos(
                  cryptoName: "Ethereum",
                  iconUrl: "assets/images/ethereum-classic-etc-logo.svg",
                  priceUs:
                      ethus == null ? "در حال بارگزاری..." : ethus.toString(),
                  priceToman: "15,210,000",
                  circleColor: Colors.white,
                  iconColor: Colors.green),
              mycryptos(
                  cryptoName: "Litecoin",
                  iconUrl: "assets/images/litecoin-ltc-logo.svg",
                  priceUs:
                      ltcus == null ? "در حال بارگزاری..." : ltcus.toString(),
                  priceToman: "2,130,000"),
              mycryptos(
                  cryptoName: "Tether",
                  iconUrl: "assets/images/tether-usdt-logo.svg",
                  priceUs: "-",
                  priceToman: "-",
                  circleColor: Colors.white),
              mycryptos(
                  cryptoName: "Tron",
                  iconUrl: "assets/images/tron-trx-logo.svg",
                  priceUs:
                      trxus == null ? "در حال بارگزاری..." : trxus.toString(),
                  priceToman: "756",
                  iconColor: Colors.red),
              mycryptos(
                  cryptoName: "Eos",
                  iconUrl: "assets/images/eos-eos-logo.svg",
                  priceUs:
                      eosus == null ? "در حال بارگزاری..." : eosus.toString(),
                  priceToman: "74,210",
                  iconColor: Colors.blueGrey),
            ],
          ),
        ),
      ),
    );
  }
}

mycryptos(
    {iconUrl,
    var priceUs,
    priceToman,
    cryptoName,
    Color circleColor,
    Color iconColor}) {
  return Padding(
    padding: EdgeInsets.all(5.0),
    child: Card(
      color: Color.fromRGBO(26, 30, 39, 100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.00)),
      ),
      child: ListTile(
        title: Text(cryptoName,
            style: TextStyle(color: Colors.white, fontSize: 13.50)),
        subtitle: Text(priceUs + " US Dollars",
            style: TextStyle(color: Colors.white, fontSize: 10.00)),
        leading: CircleAvatar(
          radius: 21.00,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            iconUrl,
            clipBehavior: Clip.antiAlias,
            semanticsLabel: "Crypto",
            color: iconColor,
          ),
        ),
        trailing: Text(priceUs + " تومان",
            style: TextStyle(color: Colors.white, fontSize: 11.00)),
      ),
    ),
  );
}
