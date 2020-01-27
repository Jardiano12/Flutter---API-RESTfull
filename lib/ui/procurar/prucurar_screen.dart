import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProcurarScreen extends StatefulWidget {
  @override
  _ProcurarScreenState createState() => _ProcurarScreenState();
}

class _ProcurarScreenState extends State<ProcurarScreen> {
  TextEditingController controller = new TextEditingController();

  Future<Null> getUserDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Procurar'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: new Column(
          children: <Widget>[
            new Container(
              color: Theme.of(context).primaryColor,
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    dense: true,
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      controller: controller,
                      decoration: new InputDecoration(
                          hintText: 'Pesquisar...', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        controller.clear();
                        onSearchTextChanged('');
                      },
                    ),
                  ),
                ),
              ),
            ),
            new Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? new ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: <Widget>[
                            new Container(
                              child: new ListTile(
                                leading: new CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                title: new Text("Nome: " +
                                    _searchResult[i].primeiroNome +
                                    ' ' +
                                    _searchResult[i].ultimoNome),
                                subtitle: Text(
                                    "Status: " + _searchResult[i].ativo),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.visibility,
                                    color: Colors.red,
                                  ),),
                                dense: true,
                              ),
                              margin: const EdgeInsets.all(0.0),
                            ),
                            Divider(
                              color: Colors.deepPurple,
                            ),
                          ],
                        );
                      },
                    )
                  : new ListView.builder(
                      itemCount: _userDetails.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            new Container(
                              child: new ListTile(
                                leading: new CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                title: new Text("Nome: " +
                                    _userDetails[index].primeiroNome +
                                    ' ' +
                                    _userDetails[index].ultimoNome),
                                subtitle: Text(
                                    "Status: " + _userDetails[index].ativo),
                                trailing: IconButton(
                                    icon: Icon(
                                  Icons.visibility,
                                  color: Colors.red,
                                ),),
                                dense: true,
                              ),
                              margin: const EdgeInsets.all(0.0),
                            ),
                            Divider(
                              color: Colors.deepPurple,
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    //  _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.primeiroNome.contains(text) ||
          userDetail.ultimoNome.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

final String url = "http://192.168.0.103:8080/crud/api/v1/funcionario";

class UserDetails {
  final int id;
  final String primeiroNome, ultimoNome, profileUrl, ativo;

  UserDetails(
      {this.id,
      this.ativo,
      this.primeiroNome,
      this.ultimoNome,
      this.profileUrl =
          'https://i.amz.mshcdn.com/3NbrfEiECotKyhcUhgPJHbrL7zM=/950x534/filters:quality(90)/2014%2F06%2F02%2Fc0%2Fzuckheadsho.a33d0.jpg'});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['id'],
      primeiroNome: json['primeiroNome'],
      ultimoNome: json['ultimoNome'],
      ativo: json['ativo'],
    );
  }
}
