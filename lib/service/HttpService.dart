import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../model/Pessoa.dart';

class HttpService {
  final String postsURL = "http://192.168.0.103:8080/crud/api/v1/funcionario"; //"https://jsonplaceholder.typicode.com/posts";

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
      throw "Can't get posts.";
    }
  }

  Future<List<Pessoa>> postPessoas({ @required primeiroNome, @required ultimoNome, @required emailId, @required ativo}) async {

      Response res = await post(postsURL, body: {
        "primeiroNome": primeiroNome,
        "ultimoNome": ultimoNome,
        "emailId": emailId,
        "ativo": ativo
      });
      if (res.statusCode == 200) {
        getPessoas();
        print(await get(postsURL));
      } else {
        throw "Can't get posts.";
      }
  }

  Future<void> deletePost(int id) async {
    Response res = await delete("$postsURL/$id");

    if (res.statusCode == 200) {
      print("DELETED");
    } else {
      throw "Can't delete post.";
    }
  }
}