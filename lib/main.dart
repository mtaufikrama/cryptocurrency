// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Crypto Currency",
      home: CryptoCurrency(),
    ),
  );
}

class CurrencyFormat {
  static String convertToIdr(dynamic number) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
    );
    return currencyFormatter.format(number);
  }
}

class CryptoCurrency extends StatefulWidget {
  const CryptoCurrency({Key? key}) : super(key: key);

  @override
  State<CryptoCurrency> createState() => _CryptoCurrencyState();
}

class _CryptoCurrencyState extends State<CryptoCurrency> {
  final String pairsUrl = "https://indodax.com/api/pairs";
  final String summariesUrl = "https://indodax.com/api/summaries";

  Future<List<dynamic>> _pairsDataCrypto() async {
    var response = await http.get(Uri.parse(pairsUrl));
    return json.decode(response.body);
  }

  Future<dynamic> _price24hrDataCrypto() async {
    var response = await http.get(Uri.parse(summariesUrl));
    return json.decode(response.body)["prices_24h"];
  }

  Future<dynamic> _tickerDataCrypto() async {
    var response = await http.get(Uri.parse(summariesUrl));
    return json.decode(response.body)["tickers"];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: Colors.white),
            Column(
              children: [
                Card(
                  margin: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                            "USNGKYejdbcsjskdnsnsndbsdnsnsndbdbcn dsjbnc bn dcbn dc"),
                        Text("USNGKY"),
                        Text("USNGKY"),
                        Text("USNGKY"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: _pairsDataCrypto(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FutureBuilder<dynamic>(
                                  future: _price24hrDataCrypto(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot24hr) {
                                    if (snapshot24hr.hasData) {
                                      return FutureBuilder<dynamic>(
                                          future: _tickerDataCrypto(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshotlast) {
                                            if (snapshotlast.hasData) {
                                              double persentase = ((int.parse(
                                                          snapshot24hr.data[
                                                              snapshot.data[index]
                                                                  ['id']]) -
                                                      int.parse(snapshotlast
                                                                  .data[
                                                              snapshot.data[index]
                                                                  ['ticker_id']]
                                                          ["last"])) /
                                                  int.parse(snapshot24hr.data[snapshot.data[index]['id']]) *
                                                  -100);

                                              return Row(
                                                children: [
                                                  Expanded(
                                                    flex: 8,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return SummariesCrypto(
                                                                ticker_id: snapshot
                                                                            .data[
                                                                        index][
                                                                    'ticker_id'],
                                                                id: snapshot
                                                                        .data[
                                                                    index]['id'],
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 70,
                                                        margin: EdgeInsets.only(
                                                            right: 10,
                                                            top: 5,
                                                            bottom: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius: BorderRadius.horizontal(
                                                                    right: Radius
                                                                        .circular(
                                                                            35)),
                                                                color: persentase <
                                                                        0.0
                                                                    ? Colors.red
                                                                    : persentase ==
                                                                            0.0
                                                                        ? Colors
                                                                            .grey
                                                                        : Colors
                                                                            .green),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    CurrencyFormat
                                                                        .convertToIdr(
                                                                      int.parse(
                                                                        snapshotlast
                                                                            .data[snapshot
                                                                                .data[index]
                                                                            [
                                                                            'ticker_id']]["last"],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        'description'],
                                                                  )
                                                                ],
                                                              ),
                                                              Text(
                                                                persentase > 0
                                                                    ? "+" +
                                                                        persentase
                                                                            .toStringAsFixed(
                                                                                3)
                                                                    : persentase ==
                                                                            0
                                                                        ? persentase
                                                                            .abs()
                                                                            .toStringAsFixed(
                                                                                3)
                                                                        : persentase
                                                                            .toStringAsFixed(3),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.vertical(
                                                                      bottom: Radius
                                                                          .circular(
                                                                              200),
                                                                      top: Radius
                                                                          .circular(
                                                                              20))),
                                                              title: Text(
                                                                snapshot.data[
                                                                        index][
                                                                    'traded_currency_unit'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        40),
                                                              ),
                                                              content: Image.network(
                                                                  snapshot.data[
                                                                          index]
                                                                      [
                                                                      'url_logo_png']),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(snapshot
                                                                    .data[index]
                                                                [
                                                                'url_logo_png']),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Container();
                                            }
                                          });
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey),
                                      );
                                    }
                                  });
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SummariesCrypto extends StatefulWidget {
  final String ticker_id;
  final String id;

  const SummariesCrypto({
    Key? key,
    required this.ticker_id,
    required this.id,
  }) : super(key: key);

  @override
  State<SummariesCrypto> createState() => _SummariesCryptoState();
}

class _SummariesCryptoState extends State<SummariesCrypto> {
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
