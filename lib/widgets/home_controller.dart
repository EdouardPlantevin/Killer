import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:killer/model/player.dart';
import 'package:killer/widgets/alert/loading_alert.dart';
import 'package:killer/widgets/rules_page.dart';
import 'package:killer/model/Database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:killer/widgets/alert/cant_change_player_when_game_on.dart';
import 'game_page.dart';
import 'package:killer/widgets/alert/add_new_player.dart';
import 'package:killer/widgets/alert/cant_lunch_game.dart';

class HomeController extends StatefulWidget {
  HomeController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {

  List<Player> players = [];
  bool gameOn = false;


  AssetImage background = AssetImage("assets/background_safe_area.png");
  AssetImage title = AssetImage("assets/title.png");

  @override
  Widget build(BuildContext context) {
    getAllPlayerFromDatabase();
    getStateOfGame();
    return new Container(
        child: new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(
              image: new DecorationImage(image: background, fit: BoxFit.fill)
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Image(image: title, fit: BoxFit.fill),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new RaisedButton(
                    child: new Text("RESTART",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        gameIsOn(false);
                        DatabaseClient().deleteAllPlayer("player", players);
                        setState(() {
                          players = [];
                          getAllPlayerFromDatabase();
                        });
                      });
                    },
                    elevation: 10.0,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
                    color: Color(0xFFE35D5E),
                  ),
                  new RaisedButton(
                    child: new Text("RÈGLES",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () {
                      _createPlayer();
                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
                        return new RulesPage();
                      }));

                    },
                    elevation: 10.0,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0))),
                    color: Color(0xFFE35D5E),
                  ),
                ],
              ),
              new Expanded(
                  child: new Container(
                    margin: EdgeInsets.all(25.0),
                    child: new Card(
                        color: Color(0x00000000),
                        child: new ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: players.length + 1,
                            itemBuilder: (context, i) {
                              if (players.length > i) {
                                Player player = players[i];
                                return new ListTile(
                                  title: new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        child: new Text(
                                          player.name,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          textScaleFactor: 1.7,
                                          style: new TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      new Container(
                                        margin: EdgeInsets.only(right: 15.0),
                                        child: new IconButton(
                                            icon: Icon(Icons.delete, color: Colors.white,),
                                            onPressed: () {
                                              if (!gameOn) {
                                                DatabaseClient().deletePlayer(player.id, 'player').then((int) {
                                                  getAllPlayerFromDatabase();
                                                });
                                              } else {
                                                cantChangePlayerWhenGameOn(context, "Aïe, vous ne pouvez pas supprimer un joueur en pleine partie");
                                              }
                                            }
                                        ),
                                      ),
                                    ],
                                  ),
                                  onLongPress: () {
                                    print("caca");
                                  },
                                  subtitle: new Image.asset("assets/trait.png"),
                                );
                              } else {
                                return new ListTile(
                                    title: new IconButton(
                                        icon: Icon(Icons.add_circle),
                                        iconSize: 60,
                                        alignment: Alignment.topRight,
                                        disabledColor: Colors.white,
                                        color: Colors.white,
                                        onPressed: (){
                                          for (Player player in players) {
                                            print(player.name);
                                          }
                                          if (!gameOn) {
                                            setState(() {
                                              addNewPlayer(context, players);
                                              getAllPlayerFromDatabase();
                                            });
                                          } else {
                                            cantChangePlayerWhenGameOn(context, "Aïe, vous ne pouvez pas ajouter un joueur en pleine partie");
                                          }
                                        })
                                );
                              }
                            })
                    ),
                  )
              ),
              new Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20.0),
                child: new RaisedButton(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Icon(Icons.play_circle_outline, size: 60, color: Colors.white),
                      new Text((players.length < 3) ? "3 Joueurs minimum" : (gameOn) ? "REPRENDRE" :"COMMENCER", textScaleFactor: 1.7, style: new TextStyle(
                          color: Colors.white
                      ),)
                    ],
                  ),
                  onPressed: () {
                    if (players.length >= 3) {
                      if (!gameOn) {
                        gameIsOn(true);
                        Player().attributeEnemy(players);
                        _animatedFlutterLogoState();
                        loadingAlert(context);
                      } else {
                        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
                          return new GamePage();
                        }));
                      }
                    } else {
                      cantLunchGame(context, players.length);
                    }
                  },
                  elevation: 10.0,
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                  color: Color(0xFFE35D5E),
                ),
              ),
            ],
          ),
        )
    );
  }

  // DATABASE

  void getAllPlayerFromDatabase() {
    DatabaseClient().allPlayer().then((players) {
      setState(() {
        this.players = players;
      });
    });
  }

  // SharedPreferences


  Future<void> getStateOfGame() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool game = sharedPreferences.getBool("gameOn");
    if (game != null) {
        gameOn = game;
    }
  }


  Future<void> gameIsOn(bool game) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    gameOn = game;
    await sharedPreferences.setBool("gameOn", gameOn);
    getStateOfGame();
  }

  _animatedFlutterLogoState() {
    new Timer(const Duration(milliseconds: 2000), () {
      prefix0.Navigator.pop(context);
      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
        return new GamePage();
      }));
    });
  }

  _createPlayer() {
    int name = 1;
    while (name != 31) {
      Map<String, dynamic> map = {'name': "${name}", 'pledge': 'lol', 'isAlive': 1, 'enemyId' : null, 'hasCounter' : null};
      Player player = new Player();
      player.fromMap(map);
      DatabaseClient().addPlayer(player);
      name++;
    }
    getAllPlayerFromDatabase();
  }

}