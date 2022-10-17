import 'package:flutter/material.dart';
import 'package:indodax_http/splash_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Crypto Currency",
      home: SplashScreen(),
    ),
  );
}
