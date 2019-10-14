import 'package:flutter/material.dart';

Future<Null> cantLunchGame(BuildContext context, int nbOfPlayers) async {
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          backgroundColor: Color(0xFFE35D5E),
          title: new Text("Il faut minimum trois joueurs !",
            textAlign: TextAlign.center,
            textScaleFactor: 1.5,
            style: new TextStyle(
                color: Colors.white
            ),),
          content: Text("Il manque ${3 - nbOfPlayers} joueur(s) pour commencer une partie"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 50.0,
                )
            ),
          ],
        );
      }
  );
}