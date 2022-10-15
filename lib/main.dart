// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:indodax_http/home_page.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Crypto Currency",
      home: HomePage(),
    ),
  );
}