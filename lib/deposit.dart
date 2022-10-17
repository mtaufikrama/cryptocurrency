import 'package:flutter/material.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logocrypto.png"),
      ),
      body: Container(
        color: Colors.blue,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
