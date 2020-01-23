import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'loaders/color_loader_3.dart';

class ProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black.withAlpha(200),
      child: Center(
        child: new Container(
          padding: const EdgeInsets.all(30.0),
          child: new GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: new Center(
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
                                              FontAwesomeIcons.heartbeat,
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
            ),
          ),
        ),
      ),
    );
  }
}
