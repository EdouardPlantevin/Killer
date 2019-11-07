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

    List<Player> arrayOfEnemy = List.from(players);
    List<Player> arrayOfPlayers = List<Player>();

    for (Player player in players) {
      Random rnd = new Random();
      var randPlayer = arrayOfEnemy[rnd.nextInt(arrayOfEnemy.length)];
      arrayOfPlayers.add(randPlayer);
      arrayOfEnemy.remove(randPlayer);
    }



    int index = 1;
    for (Player player in arrayOfPlayers) {
      if (index != players.length) {
        player.enemyId = players[index].id;
      } else {
        player.enemyId = players[0].id;
      }
      index++;
    }
    players = arrayOfPlayers;
    players = attributePledge(players);

    // Update player in Database
    for (Player player in players) {
      DatabaseClient().updatePlayer(player);
    }
  }

  List<Player> attributePledge(List<Player> players) {

    List<String> pledgeUse = [];

    for (Player player in players) {
      Random rnd = new Random();
      var index = rnd.nextInt(prefix0.pledge.length);
      var currentPledge = prefix0.pledge[index];
      pledgeUse.add(currentPledge);
      player.pledge = currentPledge;
      prefix0.pledge.remove(currentPledge);
    }
    for (String pledge in pledgeUse) {
      prefix0.pledge.add(pledge);
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


// Random attribute player

/*

        List<Player> arrayOfPlayers = List.from(players);
    List<Player> arrayOfEnemy = List.from(players);
    Player samePlayer;
    Player counter;

    for (Player player in players) {

        //Remove enemyCounter
        for (Player enemy in arrayOfPlayers) {
          if (enemy.id == player.id) {
            if (arrayOfEnemy.contains(enemy)) {
              samePlayer = enemy;
              arrayOfEnemy.remove(enemy);
            }
          }
          if (enemy.enemyId == player.id) {
            if (arrayOfEnemy.contains(enemy)) {
              counter = enemy;
              arrayOfEnemy.remove(enemy);
            }
          }
          if (enemy.hasCounter == 1) {
            if (arrayOfEnemy.contains(enemy)) {
              arrayOfEnemy.remove(enemy);
            }
          }
        }



        Random rnd = new Random();
        var randEnemy = arrayOfEnemy[rnd.nextInt(arrayOfEnemy.length)];
        player.enemyId = randEnemy.id;
        arrayOfEnemy.remove(randEnemy);

        for (Player player in arrayOfPlayers) {
          if (player.id == randEnemy.id) {
            player.hasCounter == 1;
          }
        }




      if (samePlayer != null) {
        arrayOfEnemy.add(samePlayer);
        samePlayer = null;
      }
      if (counter != null) {
        arrayOfEnemy.add(counter);
        counter = null;
      }
    }

     */