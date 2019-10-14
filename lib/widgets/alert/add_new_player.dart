import 'package:flutter/material.dart';
import 'package:killer/model/Database.dart';
import 'package:killer/model/player.dart';



// Ajout Player
Future<Null> addNewPlayer(BuildContext context, List<Player> players) async {
  String name;
  bool canAddPlayer = true;
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
                hintText: "Jean-Michel",
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
                  for (Player player in players) {
                    if(player.name == name) {
                      canAddPlayer = false;
                    }
                  }
                  if (canAddPlayer) {
                    Map<String, dynamic> map = {'name': name, 'pledge': 'lol', 'isAlive': 1, 'enemyId' : null, 'hasCounter' : null};
                    Player player = new Player();
                    player.fromMap(map);
                    DatabaseClient().addPlayer(player);
                    name = null;
                    Navigator.pop(buildContext);
                  }
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