import 'package:flutter/material.dart';
import 'package:killer/model/player.dart';

import 'game_page.dart';

class LoadingPage extends StatefulWidget {

  List<Player> players;

  LoadingPage(List<Player> players) {
    this.players = players;
  }

  LoadingPageState createState() => new LoadingPageState();

}

class LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Player().attributeEnemy(widget.players);
  }


  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new RaisedButton(
          onPressed: () {
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
              return new GamePage();
            }));
          },
        child: new Text("Jouer ?"),
      ),
    );
  }
}