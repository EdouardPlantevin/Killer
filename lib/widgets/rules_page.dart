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
        child: new Center(
          child: new Container(
            margin: EdgeInsets.all(30.0),
            child: new SingleChildScrollView(
              child: Text("Bienvenue au Jeu du killer \n\n"
                  "Vous allez entrer dans le jeu du killer, vous allez avoir une cible et une action, le but étant de faire faire l'action en question à votre cible, si vous y parvenez vous l'avez KILLÉ !!! \n\n"
                  "Suivez les directives ci-dessous pour connaître le déroulement du jeu :\n\n"
                  "1) Dans un premier temps vous devrez écrire le nom de tous les participants au jeu ( notez qu'il est imossible d'ajouter ou de supprimer des joueurs en pleine partie et qu'il faut un minimum de 3 joueurs \n\n"
                  "2) Appuyer sur le bouton 'commencer'\n\n"
                  "3) Vous arriverez sur une liste avec tous les noms des participants il suffit d'un simple clic sur votre nom pour accéder à votre tableau de chasse \n\n"
                  "4) Rester bien appuyé sur 'VOIR ACTION' pour connaître vôtre cible est l'action qu'elle doit faire\n\n"
                  "5) Si vous faites faire l'action à votre cible, vous l'avez 'Killé'. Accédez à votre tableau de chasse et cliquez sur 'J'AI KILLÉ'"
                  " Vous récuperez alors la cible et l'action de votre victime, restez appuyé de nouveau sur 'VOIR ACTION' pour les connaîtres\n\n"
                  "6) Si vous cliquez sur 'J'AI KILLÉ' est que vous êtes le dernier survivant de ce massacre... vous avez gagné !!",
                textScaleFactor: 1.5,
                style: new TextStyle(
                    color: Colors.white
                ),),
            )
          ),
        )
      ),
    );
  }

}