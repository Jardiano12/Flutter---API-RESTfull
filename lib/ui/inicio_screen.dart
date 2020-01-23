import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../dialog_controller.dart';
import '../service/HttpService.dart';
import 'cadastrar/cadastrar_screen.dart';
import 'detalhe/detalhes_screen.dart';
import '../model/Pessoa.dart';
import 'package:http/http.dart' as Http;

class InicioScreen extends StatefulWidget {
  @override
  _InicioScreenState createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final HttpService httpService = HttpService();
  int tamPessoas = 0;

  tamanho(int tamanho) {
    setState(() {
      tamPessoas = tamanho;
    });
  }

  ScrollController _scrollController; // NEW
  @override // NEW
  void initState() {
    // NEW
    super.initState(); // NEW
  }

  void _toEnd() {
    // NEW
    _scrollController.animateTo(
      // NEW
      _scrollController.position.maxScrollExtent, // NEW
      duration: const Duration(milliseconds: 500), // NEW
      curve: Curves.ease, // NEW
    ); // NEW
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.deepPurple,
      statusBarColor: Colors.deepPurple,
    ));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("API RESTfull"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              Map<String, String> headers = new HashMap();
              headers['Accept'] = 'application/json';
              headers['Content-type'] = 'application/json';

              displayProgressDialog(context);
              for (int i = 0; i <= 1000000000000000; i++) {
                Http.Response response = await Http.post(
                    "http://192.168.0.103:8080/crud/api/v1/funcionario",
                    headers: headers,
                    body: jsonEncode({
                      "id": i,
                      "primeiroNome": "Jardiano Conceicao Batista de ",
                      "ultimoNome": "Almeida",
                      "emailId": "Jardiano.IFRR.TCC@gmail.com",
                      "ativo": "false"
                    }),
                    encoding: Encoding.getByName('utf-8'));
              }
              closeProgressDialog(context);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => InicioScreen(),
              ));
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white,
            child: FutureBuilder(
              future: httpService.getPessoas(),
              //AsyncSnapshot<QuerySnapshot> snapshot
              builder:
                  (BuildContext context, AsyncSnapshot<List<Pessoa>> snapshot) {
                if (snapshot.hasError) {
                  //return new Text('Error: ${snapshot.error}');
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.database,
                          color: Colors.red,
                          size: 30.0,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.data.length == 0) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.database,
                          color: Colors.red,
                          size: 30.0,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Center(
                          child: Text("Sem dados. :(",
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  List<Pessoa> pessoas = snapshot.data;
                  // tamanho(pessoas.length);
                  print("Nome:" +  snapshot.data.length.toString());

                  return ListView(
                    children: pessoas
                        .map(
                          (Pessoa pessoa) => Column(
                            children: <Widget>[
                              ListTile(
                                //enabled: true,
                                dense: true,
                                onLongPress: () {},
                                leading:
                                    CircleAvatar(child: Text("${pessoa.id}")),
                                title: Text(pessoa.primeiroNome +
                                    " " +
                                    pessoa.ultimoNome),
                                subtitle: Text(pessoa.emailId),
                                selected: true,
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    return showDialog<bool>(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            content: Text(
                                                "Tem certeza de que deseja deletar esse servidor?"),
                                            title: Text("Atenção!"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Sim"),
                                                onPressed: () async {
                                                  await httpService
                                                      .deletePost(pessoa.id);
                                                  httpService.getPessoas();
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        InicioScreen(),
                                                  ));
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Não"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetalheScreen(
                                      pessoa: pessoa,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CadastrarScreen(
                    pessoa: Pessoa(
                        id: null,
                        primeiroNome: null,
                        ultimoNome: null,
                        emailId: null,
                        ativo: null),
                  ),
                ),
              );
            },
            child: new Icon(Icons.add),
          ),
          new CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: new Text(
              "${tamPessoas}",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
    );
  }
}
