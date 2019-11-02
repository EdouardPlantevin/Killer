import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_controller.dart';

Future<Null> win(BuildContext context) async {
  await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          backgroundColor: Color(0xFFE35D5E),
          title: new Text("Tu es le boss !!",
            textAlign: TextAlign.center,
            textScaleFactor: 1.5,
            style: new TextStyle(
                color: Colors.white
            ),),
          content: Text("Tu viens de reporter le droit de ....", textScaleFactor: 1.2,),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  gameIsOff();
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
                    return new HomeController();
                  }));
                },
                child: new Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 50.0,
                )
            ),
          ],
        );
      }
  );
}

Future<void> gameIsOff() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool("gameOn", false);
}