import 'package:killer/model/Pledge.dart' as prefix0;
import 'Database.dart';
import 'dart:math';


class Player {

  int id;
  String name;
  String pledge;
  int enemyId;
  int isAlive;
  int hasCounter;

  Player();

  void fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.pledge = map['pledge'];
    this.enemyId = map['enemyId'];
    this.isAlive = map['isAlive'];
    this.hasCounter = map['hasCounter'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': this.name,
      'pledge': this.pledge,
      'isAlive': this.isAlive,
      'enemyId' : this.enemyId,
      'hasCounter' : this.hasCounter
    };
    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }

  void attributeEnemy(List<Player> players) {

    List<Player> arrayOfPlayers = List.from(players);
    List<Player> arrayOfEnemy = List.from(players);
    Player samePlayer;

    for (Player player in players) {
      //Remove enemyCounter
      for (Player enemy in arrayOfPlayers) {
        if (enemy.id == player.id) {
          if (arrayOfEnemy.contains(enemy)) {
            samePlayer = enemy;
            arrayOfEnemy.remove(enemy);
          }
        }
      }

      Random rnd = new Random();
      var randEnemy = arrayOfEnemy[rnd.nextInt(arrayOfEnemy.length)];
      player.enemyId = randEnemy.id;
      arrayOfEnemy.remove(randEnemy);
      if (samePlayer != null) {
        arrayOfEnemy.add(samePlayer);
        samePlayer = null;
      }
    }

    players = arrayOfPlayers;
    players = attributePledge(players);
    //DatabaseClient().deleteAllPlayers();
    for (Player player in players) {
      DatabaseClient().updatePlayer(player);
    }
  }

  List<Player> attributePledge(List<Player> players) {
    for (Player player in players) {
      Random rnd = new Random();
      var index = rnd.nextInt(prefix0.pledge.length);
      var currentPledge = prefix0.pledge[index];
      player.pledge = currentPledge;
      prefix0.pledge.remove(currentPledge);

    }
    return players;
  }

  Player getEnemyPlayer(List<Player> players, Player player) {
    Player currentEnemy;
    for (Player enemy in players) {
      if (player.enemyId == enemy.id) {
        currentEnemy = enemy;
      }
    }
    return currentEnemy;
  }


}