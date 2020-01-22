import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_apirest/ui/inicio_screen.dart';
import 'package:http/http.dart' as http;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: InicioScreen(),
    );
  }
}
