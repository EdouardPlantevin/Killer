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
                  "Vous allez entrez dans le jeu du killer, vous allez avoir une cible et une action le but étant de faire faire l'action en question a vôtre cible, si vous y parvenez vous l'avez KILLER !!! \n\n"
                  "Suivez les directives ci-dessous pour connaître le déroulement du jeu :\n\n"
                  "1) Dans un premier temps vous devrez ecrire le nom de tous les participants au jeu ( notez qu'il est imossible d'ajouter ou de supprimer des joueurs en pleines partie et qu'il faut un minimum de 3 joueurs \n\n"
                  "2) Appuyer sur le bouton 'commencer'\n\n"
                  "3) Vous arriverez sur une liste avec tous les noms des participants il suffit d'un simple clic sur vôtre nom pour accéder à votre tableau de chasse \n\n"
                  "4) Rester bien appuyer sur 'VOIR ACTION' pour connaître vôtre cible est l'action qu'elle doit faire\n\n"
                  "5) Si vous faite faire l'action à vôtre cible, vous l'avez 'Killer' accéder à vôtre tableau de chasse est cliquer sur 'J'AI KILLER'"
                  " Vous récuperer alors la cible et l'action de vôtre victime, restez appuyer de nouveau sur 'VOIR ACTION' pour les connaîtres\n\n"
                  "6) Si vous cliquer sur 'J'AI KILLER' est que vous êtes le dernier survivant de se massacre vous avez ganger !!",
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