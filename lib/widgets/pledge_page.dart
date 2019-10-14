import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:killer/model/Database.dart';
import 'package:killer/model/player.dart';
import 'package:killer/widgets/alert/can_kill_enemy.dart';

// ignore: must_be_immutable
class PledgePage extends StatefulWidget {
  Player player;

  PledgePage(Player player) {
    this.player = player;
  }

  @override
  _PledgePageState createState() => new _PledgePageState();
}

class _PledgePageState extends State<PledgePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperer();
  }

  AssetImage background = AssetImage("assets/background_safe_area.png");
  AssetImage title = AssetImage("assets/title.png");

  List<Player> players = [];
  Player enemy;
  String counterName;
  bool show = false;


  @override
  Widget build(BuildContext context) {
    getEnemy();
    getCounterName();
    // TODO: implement build
    return Material(
      type:  MaterialType.transparency,
      child: new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            image: new DecorationImage(image: background, fit: BoxFit.fill)
        ),
        child: new Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 50.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20.0),
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: new IconButton(
                        icon: Icon(Icons.backspace,
                          color: Colors.white,
                          size: 50,),
                        onPressed: () {
                          Navigator.pop(context);
                        }
                    ),
                  ),
                ),
                new Container(
                  child: new Column(
                    children: <Widget>[
                      new Card(
                        elevation: 0,
                        color: Color(0x00000000),
                        child: new Container(
                          color: Color(0x00000000),
                          child: new Text((show) ? (widget.player.isAlive == 0) ? "ELIMINER" : enemy.name : "? ? ?",
                            textAlign: TextAlign.center,
                            textScaleFactor: 2,
                            style: TextStyle(
                                color: Colors.white
                            ),),
                        ),
                      ),
                      new Card(
                        elevation: 0,
                        color: Color(0x00000000),
                        child: new Container(
                          color: Color(0x00000000),
                          child: new Text((show) ? (widget.player.isAlive == 0) ? "TU EST ELIMINER" : widget.player.pledge : "? ? ? ? ? ? ?",
                            textAlign: TextAlign.center,
                            textScaleFactor: 2,
                            style: TextStyle(
                                color: Colors.white
                            ),),
                        ),
                      ),
                    ],
                  ),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Card(
                        color: Color(0xFFE35D5E),
                        elevation: 0,
                        child: new GestureDetector(
                          onLongPress: () {
                            setState(() {
                              show = !show;
                            });
                          },
                          onLongPressUp: () {
                            setState(() {
                              show = !show;
                            });
                          },
                          child: new RaisedButton(
                            onPressed: null,
                            color: Colors.transparent,
                            hoverColor: Colors.transparent,
                            disabledColor: Colors.transparent,
                            child: new Text("VOIR ACTION",
                              textScaleFactor: 2,
                              style: new TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        )
                    ),
                    new Container(
                      height: 10.0,
                    ),
                    new Card(
                        color: Color(0xFFE35D5E),
                        elevation: 0,
                        child: new GestureDetector(
                          onTap: () {
                            if (widget.player.isAlive == 1) {
                              setState(() {
                                canKillEnemy(context, widget.player, enemy);
                                recuperer();
                              });
                            }
                          },
                          child: new RaisedButton(
                            onPressed: null,
                            color: Colors.transparent,
                            hoverColor: Colors.transparent,
                            disabledColor: Colors.transparent,
                            child: new Text("J'AI KILLER",
                            textScaleFactor: 2,
                            style: new TextStyle(
                              color: Colors.white
                            ),
                            ),
                          ),
                        )
                    ),
                  ],
                )
              ]
            ),
        ),
      )
    );
  }


  void recuperer() {
    DatabaseClient().allPlayer().then((players) {
      setState(() {
        getCounterName();
        this.players = players;
      });
    });
  }

  Future<void> getEnemy() async {
    for (Player enemy in players) {
      if (widget.player.enemyId == enemy.id) {
        setState(() {
          this.enemy = enemy;
        });
      }
    }
  }

  void getCounterName() {
    for (Player enemy in players) {
      if (enemy.enemyId == widget.player.id) {
        setState(() {
          counterName = enemy.name;
        });
      }
    }
  }
}