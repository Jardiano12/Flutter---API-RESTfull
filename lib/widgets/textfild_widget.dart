import 'package:flutter/material.dart';

Widget appTextField(
    {IconData textIcon,
    String textHint,
    double sidePadding,
    FormFieldValidator<String> onBtnclickedValidate,
    TextInputType textType,
    TextEditingController controller}) {
  sidePadding == null ? sidePadding = 0.0 : sidePadding;
  textHint == null ? textHint = "" : textHint;
  //textType == null ? textType == TextInputType.text : textType;

  return Padding(
    padding: new EdgeInsets.only(
        left: sidePadding, right: sidePadding, bottom: 20.0),
    child: new Container(
      decoration: new BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
      ),
      child: new TextFormField(
        controller: controller,
        keyboardType: textType == null ? TextInputType.text : textType,
        decoration: new InputDecoration(
          // hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
          // hintText: textHint,
          labelText: textHint,
          prefixIcon: textIcon == null
              ? new Container()
              : new Icon(
                  textIcon,
                  color: Colors.white,
                ),
        ),
        style: new TextStyle(color: Colors.white),
        validator: onBtnclickedValidate,
      ),
    ),
  );
}
