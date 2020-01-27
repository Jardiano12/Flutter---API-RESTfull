import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apirest/loaders/color_loader_3.dart';
import 'package:flutter_apirest/ui/procurar/prucurar_screen.dart';
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

  @override
  void initState() {
    super.initState();
    httpService.getPessoas();
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
            icon: Icon(Icons.search),
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProcurarScreen(),
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              Map<String, String> headers = new HashMap();
              headers['Accept'] = 'application/json';
              headers['Content-type'] = 'application/json';

    Random random = new Random();

  //  setState(() => index = random.nextInt(3));

              displayProgressDialog(context);
              for (int i = 0; i <= 100; i++) {
                Http.Response response = await Http.post(
                    "http://192.168.0.102:8080/crud/api/v1/funcionario",
                    headers: headers,
                    body: jsonEncode({
                      "id": random.nextInt(100),
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
              builder: (BuildContext context, AsyncSnapshot<List<Pessoa>> snapshot) {
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
                } else if (snapshot.hasData) {
                  List<Pessoa> pessoas = snapshot.data;
                  // tamanho(pessoas.length);
                  print("Nome: " + snapshot.data.length.toString());

                  if (snapshot.data.length == 0) {
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
                  } else
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
                                  title: Text("Nome: " + pessoa.primeiroNome +
                                      " " +
                                      pessoa.ultimoNome),
                                  subtitle: Text("Status: " + pessoa.ativo),
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
                                                    await httpService.deletePost(pessoa.id);
                                                    httpService.getPessoas();
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => InicioScreen(),
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
                  return  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                Container(
                                  // height: 250.0,
//                        color: Colors.white,
                                  child: new Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: new Stack(fit: StackFit.loose, children: <Widget>[
                                          new Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[


                                              Center(
                                                child: ColorLoader3(
                                                  radius: 25.0,
                                                  dotRadius: 6.0,
                                                ),
                                              )                                  ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 25.0, left: 25.0),
                                            child: new Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                new CircleAvatar(
                                                  backgroundColor: Colors.transparent,
                                                  radius: 25.0,
                                                  child: new Icon(
                                                    FontAwesomeIcons.database,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),


                                        ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            /*          Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 25.0,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),*/


                          ],
                          ),
                        ),
//                  new CircularProgressIndicator(),
                        new SizedBox(height: 15.0),
                        new Text(
                          "Por favor, aguarde....",
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  );
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
