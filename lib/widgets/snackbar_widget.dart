import 'package:flutter/material.dart';

showSnackBar(String message, Color cor, final scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(new SnackBar(
    backgroundColor: cor,
    content: new Text(
      message,
      style: new TextStyle(color: Colors.white),
    ),
  ));
}