import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../model/Pessoa.dart';

class HttpService {
  final String postsURL = "http://192.168.0.108:8080/crud/api/v1/funcionario";

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


