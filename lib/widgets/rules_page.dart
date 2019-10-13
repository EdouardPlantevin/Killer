import 'package:flutter/material.dart';

class RulesPage extends StatefulWidget {


  @override
  _RulesPageState createState() => new _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {

  AssetImage background = AssetImage("assets/background_safe_area.png");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFFE35D5E),
        title: new Text("Règles du jeu"),
      ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
            image: new DecorationImage(image: background, fit: BoxFit.fill)
        ),
        child: new Column(
          children: <Widget>[
            Text("Regle")
          ],
        ),
      ),
    );
  }

}