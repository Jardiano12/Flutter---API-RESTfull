import 'package:flutter/material.dart';

import '../../model/Pessoa.dart';

class DetalheScreen extends StatelessWidget {
  final Pessoa pessoa;

  DetalheScreen({@required this.pessoa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pessoa.emailId),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      ListTile(
                        title: Text("ID"),
                        subtitle: Text("${pessoa.id}"),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person_pin),
                        ),
                        title: Text("Nome"),
                        subtitle: Text(pessoa.primeiroNome + " " + pessoa.ultimoNome),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.mail),
                        ),
                        title: Text("E-mail"),
                        subtitle: Text(pessoa.emailId),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.people),
                        ),
                        title: Text("Ativo"),
                        subtitle: Text("${pessoa.ativo}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}