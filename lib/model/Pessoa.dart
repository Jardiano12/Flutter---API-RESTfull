import 'package:flutter/foundation.dart';

class Pessoa {
  final int id;
  final String primeiroNome;
  final String ultimoNome;
  final String ativo;

  Pessoa({
    @required this.id,
    @required this.primeiroNome,
    @required this.ultimoNome,
    @required this.ativo,
  });

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      primeiroNome: json['primeiroNome'] as String,
      ultimoNome: json['ultimoNome'] as String,
      ativo: json['ativo'] as String,
      id: json['id'] as int,
    );
  }
}
