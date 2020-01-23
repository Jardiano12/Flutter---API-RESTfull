import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apirest/model/Pessoa.dart';
import 'package:flutter_apirest/service/HttpService.dart';
import 'package:flutter_apirest/ui/inicio_screen.dart';
import 'package:flutter_apirest/widgets/snackbar_widget.dart';
import 'package:flutter_apirest/widgets/textfild_widget.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:http/http.dart' as Http;


class CadastrarScreen extends StatefulWidget {
  final Pessoa pessoa;

  const CadastrarScreen({this.pessoa});
  @override
  _CadastrarScreenState createState() => _CadastrarScreenState();
}

class _CadastrarScreenState extends State<CadastrarScreen> {

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var primeiroNomeControlle = TextEditingController();
  var ultimoNomeControlle = TextEditingController();
  var emailIdControlle = TextEditingController();
  var uid;
  final HttpService httpService = HttpService();
  String auxAtivo;

  @override
  void initState() {
    super.initState();
    primeiroNomeControlle = TextEditingController(text: widget.pessoa.primeiroNome);
    ultimoNomeControlle = TextEditingController(text: widget.pessoa.ultimoNome);
    emailIdControlle = TextEditingController(text: widget.pessoa.emailId);
    uid = widget.pessoa.id;
  }
  @override
  void dispose() {
    primeiroNomeControlle.clear();
    ultimoNomeControlle.clear();
    emailIdControlle.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
          title: Text("Cadastrar"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.deepPurple,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            appTextField(
                                controller: primeiroNomeControlle,
                                sidePadding: 8.0,
                                textHint: 'Primeiro nome',
                                textIcon: Icons.person_pin,
                                textType: TextInputType.text,
                                onBtnclickedValidate: (validar) {
                                  if (validar.isEmpty) {
                                    showSnackBar("Primeiro nome não pode ser vazio!", Colors.red, scaffoldKey);
                                    return "Primeiro nome não pode ser vazio!";
                                  }
                                }
                            ),

                            appTextField(
                                controller: ultimoNomeControlle,
                                sidePadding: 8.0,
                                textHint: 'Ultimo nome',
                                textIcon: Icons.person_pin,
                                textType: TextInputType.text,
                                onBtnclickedValidate: (validar) {
                                  if (validar.isEmpty) {
                                    showSnackBar("Ultimo nome não pode ser vazio!", Colors.red, scaffoldKey);
                                    return "Ultimo nome não pode ser vazio!";
                                  }
                                }
                            ),

                            appTextField(
                                controller: emailIdControlle,
                                sidePadding: 8.0,
                                textHint: 'E-mail',
                                textIcon: Icons.mail,
                                textType: TextInputType.text,
                                onBtnclickedValidate: (validar) {
                                  if (validar.isEmpty) {
                                    showSnackBar("E-mail não pode ser vazio!", Colors.red, scaffoldKey);
                                    return "E-mail não pode ser vazio!";
                                  }
                                }
                            ),

                            Text("Status".toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),),
                            RadioButtonGroup(
                                labels: <String>[
                                  "Ativo",
                                  "Inativo",
                                ],
                                onSelected: (String selected) {
                                  setState(() {
                                    auxAtivo = selected;
                                  });
                                }
                            )

                          ],
                        ),
                      ),

                      Padding(
                        padding: new EdgeInsets.all(8.0),
                        child: new RaisedButton(
                          color: Colors.deepPurple,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(15.0))),
                          onPressed: () async {


                            if(_formKey.currentState.validate()){

                            } if (auxAtivo == null) {
                              showSnackBar("Status não pode ser vazio!", Colors.red, scaffoldKey);
                            } else {
                              if( uid == null) {
                                httpService.postPessoas(
                                    primeiroNome: primeiroNomeControlle.text,
                                    ultimoNome: ultimoNomeControlle.text,
                                    emailId: emailIdControlle.text,
                                    ativo: 'mAtivo');
                              } else {
                           /*     httpService.putPessoas(
                                    primeiroNome: primeiroNomeControlle.text,
                                    ultimoNome: ultimoNomeControlle.text,
                                    emailId: emailIdControlle.text,
                                    ativo: 'mAtivo');*/

                                Map<String, String> headers = new HashMap();
                                headers['Accept'] = 'application/json';
                                headers['Content-type'] = 'application/json';

                                Http.Response response = await Http.post(
                                    "http://192.168.0.103:8080/crud/api/v1/funcionario",
                                    headers: headers,
                                    body: jsonEncode({
                                      "id": 101,
                                      "primeiroNome": "Jardiano Conceicao Batista de ",
                                      "ultimoNome": "Almeida",
                                      "emailId": "Jardiano.IFRR.TCC@gmail.com",
                                      "ativo": "false"
                                    }),
                                    encoding: Encoding.getByName('utf-8')
                                );
                              }

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => InicioScreen(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 50.0,
                            child: new Center(
                              child: uid == null ? new Text('Cadastrar', style: new TextStyle(color: Colors.white, fontSize: 18.0),)
                              : new Text('Atualizar', style: new TextStyle(color: Colors.white, fontSize: 18.0),)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}