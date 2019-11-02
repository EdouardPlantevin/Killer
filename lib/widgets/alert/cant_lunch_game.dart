import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<Null> cantLunchGame(BuildContext context, int nbOfPlayers) async {
  Text title = new Text("Il faut au minimum trois joueurs !", textAlign: TextAlign.center, textScaleFactor: 1.5, style: new TextStyle(
      color: Colors.white
  ),);
  Text content = new Text("Il manque ${3 - nbOfPlayers} joueur(s) pour commencer une partie");
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          backgroundColor: Color(0xFFE35D5E),
          title: title,
          content: content,
          actions: <Widget>[
            buttonPop(context)
          ],
        );
      }
  );
}

Widget buttonPop(BuildContext context) {
  return new FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: new Icon(
        Icons.done,
        color: Colors.white,
        size: 50.0,
      )
  );
}

