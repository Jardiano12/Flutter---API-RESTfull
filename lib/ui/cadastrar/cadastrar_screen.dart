import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apirest/model/Pessoa.dart';
import 'package:flutter_apirest/service/HttpService.dart';
import 'package:flutter_apirest/ui/inicio_screen.dart';
import 'package:flutter_apirest/widgets/snackbar_widget.dart';
import 'package:flutter_apirest/widgets/textfild_widget.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class CadastrarScreen extends StatefulWidget {
  @override
  _CadastrarScreenState createState() => _CadastrarScreenState();
}

class _CadastrarScreenState extends State<CadastrarScreen> {

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var primeiroNomeControlle = TextEditingController();
  var ultimoNomeControlle = TextEditingController();
  var emailIdControlle = TextEditingController();
  String ativoControlle = '';
  final HttpService httpService = HttpService();

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
        body: SingleChildScrollView(
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
                          textIcon: Icons.person_pin,
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
                              ativoControlle == selected;
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
                    onPressed: () {
                      if(_formKey.currentState.validate()){

                      } if (ativoControlle == '') {
                        showSnackBar("Status não pode ser vazio!", Colors.red, scaffoldKey);
                      } else {
                        httpService.postPessoas(
                            primeiroNome: primeiroNomeControlle.text,
                            ultimoNome: ultimoNomeControlle.text,
                            emailId: emailIdControlle.text,
                            ativo: ativoControlle);
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
                        child: new Text(
                          'Cadastrar',
                          style: new TextStyle(color: Colors.white,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}