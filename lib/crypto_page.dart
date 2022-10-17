// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoPage extends StatefulWidget {
  final String ticker_id;
  final String id;

  const CryptoPage({
    Key? key,
    required this.ticker_id,
    required this.id,
  }) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  final String summariesUrl = "https://indodax.com/api/summaries";

  Future<dynamic> _tickerDataCrypto() async {
    var response = await http.get(Uri.parse(summariesUrl));
    return json.decode(response.body)["tickers"][widget.ticker_id];
  }

  Future<dynamic> _price24hrDataCrypto() async {
    var response = await http.get(Uri.parse(summariesUrl));
    return json.decode(response.body)["prices_24h"][widget.id];
  }

  Future<dynamic> _price7dDataCrypto() async {
    var response = await http.get(Uri.parse(summariesUrl));
    return json.decode(response.body)["prices_7d"][widget.id];
  }

  Future<dynamic> _tradesDataCrypto() async {
    final String tradesUrl = "https://indodax.com/api/${widget.id}/trades";
    var response = await http.get(Uri.parse(tradesUrl));
    return json.decode(response.body)["tickers"][widget.ticker_id];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<dynamic>(
              future: _tickerDataCrypto(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(snapshot.data["name"]),
                      Text(snapshot.data["high"]),
                      Text(snapshot.data["low"]),
                      Text(snapshot.data["last"]),
                    ],
                  );
                } else {
                  return Container(
                    color: Colors.red,
                  );
                }
              },
            ),
            FutureBuilder<dynamic>(
              future: _price24hrDataCrypto(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                } else {
                  return Container(
                    color: Colors.red,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
