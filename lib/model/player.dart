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

    List<Player> playersEnemy = players;
    int index = 0;

    for (Player player in players) {
      while (player.id == playersEnemy[index].id || player.id == playersEnemy[index].enemyId || playersEnemy[index].hasCounter == 1) {
        var randomizer = new Random();
        index = randomizer.nextInt(players.length);
      }
      var indexEnemy = players.indexOf(playersEnemy[index]);
      players[indexEnemy].hasCounter = 1;
      player.enemyId = playersEnemy[index].id;
      playersEnemy = players;
    }

    players = attributePledge(players);
    DatabaseClient().deleteAllPlayers();
    for (Player player in players) {
      DatabaseClient().addPlayer(player);
    }
  }

  List<Player> attributePledge(List<Player> players) {
    for (Player player in players) {
      var randomizer = new Random();
      int index = randomizer.nextInt(prefix0.pledge.length);
      player.pledge = prefix0.pledge[index];
      prefix0.pledge.removeAt(index);
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