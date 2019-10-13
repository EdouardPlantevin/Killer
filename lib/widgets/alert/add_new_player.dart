import 'package:flutter/material.dart';
import 'package:killer/model/Database.dart';
import 'package:killer/model/player.dart';



// Ajout Player
Future<Null> addNewPlayer(BuildContext context) async {
  String name;
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          backgroundColor: Color(0xFFE35D5E),
          title: new Text("Ajouter un joueur",
            textAlign: TextAlign.center,
            textScaleFactor: 1.5,
            style: new TextStyle(
                color: Colors.white
            ),),
          content: new TextField(
            cursorColor: Colors.white,
            style: new TextStyle(
                color: Colors.white
            ),
            decoration: new InputDecoration(
                labelText: "Nom",
                focusColor: Colors.white,
                fillColor: Colors.white,
                hoverColor: Colors.white,
                hintText: "Tocard",
                hintStyle: new TextStyle(
                    color: Colors.blueGrey[500]
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,)
                ),
                labelStyle: new TextStyle(
                    color: Colors.white,
                    fontSize: 25.0
                )
            ),
            onChanged: (String str) {
              name = str;
            },
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Map<String, dynamic> map = {'name': name, 'pledge': 'lol', 'isAlive': 1, 'enemyId' : null, 'hasCounter' : null};
                  Player player = new Player();
                  player.fromMap(map);
                  DatabaseClient().addPlayer(player);
                  name = null;
                  Navigator.pop(buildContext);
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