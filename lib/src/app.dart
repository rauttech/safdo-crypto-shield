/*
Project: Safdo Crypto Shield
Owner: Deepak Raghunath Raut
Disclaimer: This project is completely owned by Deepak Raghunath Raut.
By using, modifying, or redistributing this code you agree that ownership remains with Deepak Raghunath Raut.
License: MIT (see LICENSE file)
*/
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

class SafdoApp extends StatelessWidget {
  const SafdoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safdo Crypto Shield',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
