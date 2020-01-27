import 'package:flutter/material.dart';
import 'package:flutter_apirest/ui/cadastrar/cadastrar_screen.dart';

import '../../model/Pessoa.dart';

class DetalheScreen extends StatelessWidget {
  final Pessoa pessoa;

  DetalheScreen({@required this.pessoa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text(pessoa.primeiroNome),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CadastrarScreen(
                    pessoa: Pessoa(
                        id: pessoa.id,
                        primeiroNome: pessoa.primeiroNome,
                        ultimoNome: pessoa.ultimoNome,
                        ativo: pessoa.ativo),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.deepPurple,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              shape: new RoundedRectangleBorder(
                side: new BorderSide(color: Colors.redAccent, width: 2.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                children: <Widget>[

                  Column(
                    children: <Widget>[
                      new Container(
                        height: 250.0,
                        color: Colors.white,
                        child: new Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: new Stack(
                                  fit: StackFit.loose,
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.deepPurple,
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 30.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 90.0, right: 100.0),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 25.0,
                                              child: new Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )),
                                  ]),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text("${pessoa.id}"),
                    ),
                    title: Text("ID"),
                    subtitle: Text("${pessoa.id}"),
                  ),
                  Divider(
                    color: Colors.deepPurple,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person_pin),
                    ),
                    title: Text("Nome"),
                    subtitle:
                        Text(pessoa.primeiroNome + " " + pessoa.ultimoNome),
                  ),
                  Divider(
                    color: Colors.deepPurple,
                  ),

                  Divider(
                    color: Colors.deepPurple,
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
          ),
        ),
      ),
    );
  }
}
