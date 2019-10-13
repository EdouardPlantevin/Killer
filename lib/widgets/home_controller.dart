import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:killer/model/player.dart';
import 'package:killer/widgets/rules_page.dart';
import 'package:killer/model/Database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game_page.dart';


class HomeController extends StatefulWidget {
  HomeController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperer();
  }

  List<Player> players = [];
  String name;
  String key = "gameOn";
  bool gameOn = false;


  AssetImage background = AssetImage("assets/background_safe_area.png");
  AssetImage title = AssetImage("assets/title.png");
  List<String> test = ["Edouard", "Juliette", "Alex"];


  @override
  Widget build(BuildContext context) {
    obtenir();
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
                        DatabaseClient().deleteAllPlayers();
                        recuperer();
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
                    margin: EdgeInsets.all(30.0),
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
                                              DatabaseClient().deletePlayer(player.id, 'player').then((int) {
                                                recuperer();
                                              });
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
                                        onPressed: ajouter)
                                );
                              }
                            })
                    ),
                  )
              ),
              new Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 50.0),
                child: new RaisedButton(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Icon(Icons.play_circle_outline, size: 60, color: Colors.white),
                      new Text((gameOn) ? "REPRENDRE" :"COMMENCER", textScaleFactor: 1.7, style: new TextStyle(
                          color: Colors.white
                      ),)
                    ],
                  ),
                  onPressed: () {
                    if (players.length >= 3) {
                      if (!gameOn) {
                        gameIsOn(true);
                        Player().attributeEnemy(players);
                      }
                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
                        return new GamePage();
                      }));
                    } else {
                      print("Aller vous faire foutre");
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

  void recuperer() {
    DatabaseClient().allPlayer().then((players) {
      setState(() {
        this.players = players;
      });
    });
  }

  // Ajout Player
  Future<Null> ajouter() async {
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
              style: new prefix0.TextStyle(
                  color: Colors.white
              ),
              decoration: new InputDecoration(
                  labelText: "Nom",
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: "Tocard",
                  hintStyle: new prefix0.TextStyle(
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
                    DatabaseClient().addPlayer(player).then((i) => recuperer());
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

  Future<void> obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool game = sharedPreferences.getBool(key);
    if (game != null) {
      setState(() {
        gameOn = game;
      });
    }
  }


  Future<void> gameIsOn(bool game) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    gameOn = game;
    await sharedPreferences.setBool(key, gameOn);
    obtenir();
  }

}