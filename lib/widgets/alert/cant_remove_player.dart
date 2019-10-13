import 'package:flutter/material.dart';


Future<Null> ajouter(BuildContext context) async {
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          backgroundColor: Color(0xFFE35D5E),
          title: new Text("Aie vous ne pouver pas supprimer un joueur en pleine partie",
            textAlign: TextAlign.center,
            textScaleFactor: 1.5,
            style: new TextStyle(
                color: Colors.white
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Icon(
                  Icons.add_circle,
                  color: Colors.white,
                  size: 50.0,
                )
            )
          ],
        );
      }
  );
}