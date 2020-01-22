import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../service/HttpService.dart';
import 'cadastrar/cadastrar_screen.dart';
import 'detalhe/detalhes_screen.dart';
import '../model/Pessoa.dart';

class InicioScreen extends StatefulWidget {
  @override
  _InicioScreenState createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final HttpService httpService = HttpService();
  int tamPessoas = 0;

  tamanho(int tamanho){
    setState(() {
      tamPessoas = tamanho;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.deepPurple,
      statusBarColor: Colors.deepPurple,
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text("API RESTfull"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => InicioScreen(),))),
        ],
      ),
      body: FutureBuilder(
        future: httpService.getPessoas(),
        builder: (BuildContext context, AsyncSnapshot<List<Pessoa>> snapshot) {
          if(snapshot.data.isEmpty){
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.database, color: Colors.red, size: 30.0,),
                  SizedBox(height: 15.0,),
                  Center( child: Text("Sem dados. :("),),
                ],
              ),
            );
          } else if (snapshot.hasData) {

            List<Pessoa> pessoas = snapshot.data;

             // tamanho(pessoas.length);
            return ListView(
              children: pessoas
                  .map(
                    (Pessoa pessoa) =>
                    ListTile(
                      leading: CircleAvatar(child: Text("${pessoa.id}")),
                      title: Text(pessoa.primeiroNome + " " + pessoa.ultimoNome),
                      subtitle: Text(pessoa.emailId),
                      selected: true,
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
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
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => InicioScreen(),));
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
                      onTap: () =>
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalheScreen(
                                    pessoa: pessoa,
                                  ),
                            ),
                          ),
                    ),
              )
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CadastrarScreen(),
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
