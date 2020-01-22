import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apirest/ui/inicio_screen.dart';
import 'package:http/http.dart' as http;

/*
void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}
*/

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

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  String teste = "Esperando um dado";
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.0.103:8080/crud/api/v1/funcionario"),
//        Uri.encodeFull("https://192.168.0.103/crud"),
        headers: {
          "Accept": "application/json"
        }
    );
    data = json.decode(response.body);
    print(data[0]["primeiroNome"]);
    print(await http.read('http://192.168.0.103:8080/crud/api/v1/funcionario'));
  //  print(await http.read('https://jsonplaceholder.typicode.com/posts'));


    teste = data[1]["primeiroNome"];
    return "Success!";
  }

  void getHttp() async {
    try {
      Response response = await Dio().get("http://192.168.0.103:8080/crud/api/v1/funcionario");
      print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(teste),
            new Center(
              child: new RaisedButton(
                child: new Text("Get data"),
                onPressed: getHttp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}