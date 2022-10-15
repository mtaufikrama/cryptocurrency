import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:indodax_http/crypto_page.dart';
import 'package:http/http.dart' as http;
import 'package:indodax_http/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        appBar: AppBar(
          title: Text("Crypto"),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.only(top: 200),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 79, 143),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
            ),
            Column(
              children: [
                Card(
                  color: Colors.blue,
                  margin: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 70),
                    child: Column(
                      children: const [
                        Text(
                            "USNGKYejdbcsjskdnsnsndbsdnsnsndbdbcn dsjbnc bn dcbn dc"),
                        Text("USNGKY"),
                        Text("USNGKY"),
                        Text("USNGKY"),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: MaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(25),
                            ),
                          ),
                          height: 50,
                          onPressed: () {
                            setState(() {});
                          },
                          color: Colors.blue,
                          child: const Text("DEPOSIT"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: MaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(25),
                            ),
                          ),
                          height: 50,
                          onPressed: () {
                            setState(() {});
                          },
                          color: Colors.blue,
                          child: const Text("WITHDRAW"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
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

                                              dynamic namecrypto = snapshotlast
                                                      .data[
                                                  snapshot.data[index]
                                                      ['ticker_id']]["name"];
                                              dynamic tickerID = snapshot
                                                  .data[index]['ticker_id'];
                                              dynamic idCrypto = snapshot
                                                  .data[index]['ticker_id'];
                                              int hargaCrypto = int.parse(
                                                snapshotlast.data[
                                                    snapshot.data[index]
                                                        ['ticker_id']]["last"],
                                              );
                                              dynamic namaIDR =
                                                  snapshot.data[index]
                                                      ['traded_currency_unit'];
                                              dynamic logoCrypto = snapshot
                                                  .data[index]['url_logo_png'];

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
                                                              return CryptoPage(
                                                                ticker_id:
                                                                    tickerID,
                                                                id: idCrypto,
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 5,
                                                                bottom: 5,
                                                                right: 10),
                                                        child: Material(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .horizontal(
                                                            right:
                                                                Radius.circular(
                                                                    50),
                                                          ),
                                                          color: persentase <
                                                                  0.0
                                                              ? Colors.red
                                                              : persentase ==
                                                                      0.0
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .green,
                                                          elevation: 5,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .horizontal(
                                                                right: Radius
                                                                    .circular(
                                                                        40),
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 12,
                                                                    bottom: 2),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 20),
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
                                                                        namecrypto,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        CurrencyFormat
                                                                            .convertToIdr(
                                                                          hargaCrypto,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    persentase >
                                                                            0
                                                                        ? "+${persentase.toStringAsFixed(3)}"
                                                                        : persentase ==
                                                                                0
                                                                            ? persentase.abs().toStringAsFixed(3)
                                                                            : persentase.toStringAsFixed(3),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
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
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.vertical(
                                                                      bottom: Radius
                                                                          .circular(
                                                                              200),
                                                                      top: Radius
                                                                          .circular(
                                                                              20))),
                                                              title: Text(
                                                                namaIDR,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        40),
                                                              ),
                                                              content:
                                                                  Image.network(
                                                                      logoCrypto),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                logoCrypto),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
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
                                        margin: const EdgeInsets.symmetric(
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
                        return const Center(child: CircularProgressIndicator());
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