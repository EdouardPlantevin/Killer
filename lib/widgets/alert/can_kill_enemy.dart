import 'package:flutter/material.dart';
import 'package:killer/model/Database.dart';
import 'package:killer/model/player.dart';
import 'package:killer/widgets/alert/win_the_game.dart';


Future<Null> canKillEnemy(BuildContext context, Player player, Player enemy) async {
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          backgroundColor: Color(0xFFE35D5E),
          title: new Text("Tu es vraiment un boss ?",
            textAlign: TextAlign.center,
            textScaleFactor: 1.5,
            style: new TextStyle(
                color: Colors.white
            ),),
          content: Text("Tu es sur et certain d'avoir killer ta cible ?", textScaleFactor: 1.2,),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 50.0,
                )
            ),
            new FlatButton(
                child:  new Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 50.0,
                ),
                onPressed: () {
                  if (enemy.enemyId == player.id) {
                    win(context);
                  } else {
                    enemy.isAlive = 0;
                    player.enemyId = enemy.enemyId;
                    player.pledge = enemy.pledge;
                    DatabaseClient().updatePlayer(enemy);
                    DatabaseClient().updatePlayer(player);
                    Navigator.pop(context);
                  }
                })
          ],
        );
      }
  );
}