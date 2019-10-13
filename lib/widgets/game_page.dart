import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:killer/model/Database.dart';
import 'package:killer/model/player.dart';
import 'package:killer/widgets/pledge_page.dart';

class GamePage extends StatefulWidget {


  @override
  _GamePageState createState() => new _GamePageState();
}

class _GamePageState extends State<GamePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperer();
  }

  AssetImage background = AssetImage("assets/background_safe_area.png");
  AssetImage title = AssetImage("assets/title.png");

  List<Player> players = [];

  @override
  Widget build(BuildContext context) {
    recuperer();
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
            child: new Column(
              children: <Widget>[
                new Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 20, left: 20),
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height / 6,
                    child: new Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: new IconButton(
                          alignment: Alignment.centerLeft,
                          icon: Icon(Icons.backspace,
                            color: Colors.white,
                            size: 50,),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      ),
                    )
                ),
                new Expanded(
                  child: new Card(
                    elevation: 0,
                    color: Color(0x00000000),
                    child: new ListView.builder(
                      itemCount: players.length,
                      itemBuilder: (context, i) {
                        Player currentPlayer = players[i];
                        return ListTile(
                          onTap: () {
                            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
                              return new PledgePage(currentPlayer);
                            }));

                          },
                          title: new Text(players[i].name,
                            textAlign: TextAlign.center,
                            textScaleFactor: 2.7,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: new Image.asset("assets/trait.png"),
                        );
                      },
                    ),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(bottom: 30.0, top: 30.0),
                  child: new Text("Appuis sur ton nom pour connaître ta cible",
                    textScaleFactor: 2,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white
                    ),
                  )
                ),
              ],
            )
        ),
      ),
    );
  }


  void recuperer() {
    DatabaseClient().allPlayer().then((players) {
      setState(() {
        this.players = players;
      });
    });
  }


}