import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as Http;


import '../model/Pessoa.dart';

class HttpService {
  final String postsURL = "http://192.168.0.102:8080/crud/api/v1/funcionario";

  Future<List<Pessoa>> getPessoas() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Pessoa> posts = body
          .map(
            (dynamic item) => Pessoa.fromJson(item),
      )
          .toList();

      return posts;
    } else {
      throw "Não é possível obter postagens.";
    }
  }


  void postPessoas({ @required primeiroNome, @required ultimoNome, @required emailId, @required ativo}) async {

/*
      return post(postsURL, body: {
        "primeiroNome": primeiroNome,
        "ultimoNome": ultimoNome,
        "emailId": emailId,
        "ativo": ativo
      }).then((response){
        //check response status, if response status OK
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          if (data.length > 0) {
            //Convert your JSON to Model here
          }
          else {
            //Get Your ERROR message's here
            var errorMessage = data["error_msg"];
          }
        }
      });
*/

      Map<String, String> headers = new HashMap();
      headers['Accept'] = 'application/json';
      headers['Content-type'] = 'application/json';

      Http.Response response = await Http.post(postsURL,
          headers: headers,
          body: jsonEncode({
          "primeiroNome": primeiroNome,
          "ultimoNome": ultimoNome,
          "email": emailId,
          "ativo": "ativo"
          }),
          encoding: Encoding.getByName('utf-8')
      );

  }

  void putPessoas({ @required primeiroNome, @required ultimoNome, @required emailId, @required ativo}) async {

    return put(postsURL, body: {
      "primeiroNome": primeiroNome,
      "ultimoNome": ultimoNome,
      "emailId": emailId,
      "ativo": ativo
    }).then((response){

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data.length > 0) {

        } else {
          var errorMessage = data["error_msg"];
        }
      }
    });

  }
  Future<void> deletePost(int id) async {
    Response res = await delete("$postsURL/$id");

    if (res.statusCode == 200) {
      print("Deletado");
    } else {
      throw "Não é possível excluir o servidor.";
    }
  }
}


