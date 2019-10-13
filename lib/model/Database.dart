import 'dart:async' as prefix0;
import 'dart:io';
import 'package:killer/model/player.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseClient {

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      //Create Database
      _database = await create();
      return _database;
    }
  }

  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databaseDirectory = join(directory.path, 'database.db');
    var bdd = await openDatabase(databaseDirectory, version: 1, onCreate: _onCreate);
    return bdd;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE player (
    id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL, 
    pledge TEXT NOT NULL, 
    enemyId INTEGER, 
    isAlive INTEGER,
    hasCounter INTEGER
    )
    """);
  }

  // ECRITURE DES DONNEES

  Future<Player> addPlayer(Player player) async {
    Database maDatabase = await database;
    player.id = await maDatabase.insert('player', player.toMap());
    return player;
  }

  Future<int> updatePlayer(Player player) async {
    Database maDatabase = await database;
    return maDatabase.update('player', player.toMap(), where: 'id = ?', whereArgs: [player.id]);
  }

  Future<Player> upsertPlayer(Player player) async {
    Database maDatabase = await database;
    if (player.id == null) {
      player.id = await maDatabase.insert('player', player.toMap());
    } else {
      await maDatabase.update('player', player.toMap(), where: 'id = ?', whereArgs: [player.id]);
    }
    return player;
  }


  Future<int> deletePlayer(int id, String table) async {
    Database maDatabase = await database;
    return await maDatabase.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  void deleteAllPlayers() async {
    Database maDatabase = await database;
    maDatabase.delete("player");
  }


  /* LECTURE DES DONNEES */

  Future<List<Player>> allPlayer() async {
    Database maDatabase = await database;
    List<Map<String, dynamic>> resultat = await maDatabase.rawQuery('SELECT * FROM player');
    List<Player> players = [];
    resultat.forEach((map) {
      Player player = new Player();
      player.fromMap(map);
      players.add(player);
    });
    return players;
  }



}